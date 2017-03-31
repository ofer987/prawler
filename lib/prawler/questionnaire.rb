# frozen_string_literal: true

class Questionnaire
  attr_reader :pull_requests
  alias to_a pull_requests

  def initialize(client, repos, pull_requests)
    @client = client
    @repos = Array(repos).map(&:to_s)

    @pull_requests = pull_requests
  end

  def find_by_number(number)
    new_questionnaire do
      @pull_requests.select { |pr| pr.number == number.to_i }
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
      rescue => ex
        puts 'Error!'
        puts 'Do you have internet connection?'
        puts ex

        []
      end

    self.class.new(@client, @repos, new_pull_requests)
  end
end
