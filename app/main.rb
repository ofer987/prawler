# frozen_string_literal: true

require 'octokit'

class Main
  attr_accessor :token

  def initialize(token)
    @token = token

    @repos = ['tricycle/bellroy']
    @client = Octokit::Client.new(access_token: @token)
  end

  def pull_requests
    @repos.flat_map do |repo|
      @client
        .pull_requests(repo, state: 'all')
        .select { |key, _| key[:user][:login] == login }
    end
  end

  def questions
    Questions.new(@client, @repos, pull_requests)
  end

  private

  def login
    @client.login
  end
end
