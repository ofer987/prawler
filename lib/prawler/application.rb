# frozen_string_literal: true

module Prawler
  class Application
    attr_accessor :token
    attr_reader :login

    def initialize(token, repos = nil, login = nil)
      @token = token
      @client = Octokit::Client.new(access_token: @token, auto_paginate: true)

      @login = login || @client.login
      @repos = repos || remotes
    end

    def questionnaire
      Questionnaire.new(@client, @repos, @login, nil)
    end

    private

    def remotes
      cli = Prawler::Git::Cli.new

      Prawler::Git::Config(cli).remotes
    end
  end
end
