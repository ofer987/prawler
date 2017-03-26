# frozen_string_literal: true

require 'pry-byebug'

class Questions
  attr_reader :pull_requests

  def initialize(client, repos, pull_requests)
    @client = client
    @repos = Array(repos).map(&:to_s)

    @pull_requests = pull_requests
  end

  def open
    prs = @pull_requests.select { |key, _| key[:state] == 'open' }

    self.class.new(@client, @repos, prs)
  end

  def closed
    prs = @pull_requests.select { |key, _| key[:state] == 'closed' }

    self.class.new(@client, @repos, prs)
  end

  def find_by_number(number)
    prs = @pull_requests.select { |pr| pr.number == number.to_i }

    self.class.new(@client, @repos, prs)
  end

  def approved_reviews
    prs = @pull_requests.select do |pr|
      @client
        .pull_request_reviews(
          pr.base.repo.full_name,
          pr.number,
          accept: 'application/vnd.github.black-cat-preview+json'
        ).any? { |review| review.state == 'APPROVED' }
    end

    self.class.new(@client, @repos, prs)
  end

  private

  def login
    @client.login
  end
end
