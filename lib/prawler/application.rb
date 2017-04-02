# frozen_string_literal: true

require 'octokit'

require 'prawler/git/cli'
require 'prawler/git/config'

module Prawler
  class Application
    attr_reader :login

    def initialize(repos = nil, login = nil)
      # what if token not valid?
      @client = Octokit::Client.new(access_token: token, auto_paginate: true)

      @login = login || @client.login
      @repos = repos || remotes
    end

    def questionnaire
      Questionnaire.new(@client, @repos, @login, nil)
    end

    private

    def remotes
      git_config.remotes
    end

    def token
      git_config.prawler_token
    end

    def git_config
      @git_config ||= Git::Config.new(Git::Cli.new)
    end
  end
end
