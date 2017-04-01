# frozen_string_literal: true

require 'octokit'

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
      cli = Git::Cli.new

      Git::Config(cli).remotes
    end
  end
end
