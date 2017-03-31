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
      @repos = repos || @client.repos.map(&:full_name)
    end

    def open_pull_requests
      @repos.flat_map do |repo|
        @client
          .pull_requests(repo, state: 'open')
          .select { |key, _| key[:user][:login] == login }
      end
    rescue => ex
      puts 'Are you connected to the internet?'
      puts 'Is your token valid?'
      puts ex

      []
    end

    def questionnaire
      Questionnaire.new(@client, @repos, open_pull_requests)
    end
  end
end
