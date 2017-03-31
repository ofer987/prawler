# frozen_string_literal: true

module Prawler
  class Questionnaire
    attr_reader :pull_requests
    alias to_a pull_requests

    def initialize(client, repos, login, pull_requests)
      @client = client
      @repos = repos
      @login = login

      @pull_requests = Array(pull_requests)
    end

    def find_by_number(number)
      new_questionnaire do
        @pull_requests.select { |pr| pr.number == number.to_i }
      end
    end

    def open_pull_requests
      new_questionnaire do
        @repos.flat_map do |repo|
          @client
            .pull_requests(repo, state: 'open')
            .select { |key, _| key[:user][:login] == @login }
        end
      end
    end

    def approved_reviews
      new_questionnaire do
        @pull_requests.select do |pr|
          @client
            .pull_request_reviews(
              pr.base.repo.full_name,
              pr.number,
              accept: 'application/vnd.github.black-cat-preview+json'
            ).any? { |review| review.state == 'APPROVED' }
        end
      end
    end

    private

    def new_questionnaire
      new_pull_requests =
        begin
          yield
        rescue Faraday::ConnectionFailed => ex
          puts 'Are you connected to the internet?'
          puts 'Is your token valid?'
          puts ex

          []
        rescue => ex
          puts ex

          []
        end

      self.class.new(@client, @repos, @login, new_pull_requests)
    end
  end
end
