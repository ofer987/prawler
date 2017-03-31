#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/environment'

repos = (ENV['REPOS'] || '').split(',').map(&:strip)
repos = repos.present? ? repos : nil

login = (ENV['LOGIN'] || '').strip
login = login.present? ? login : nil

prs = Main
  .new(ENV['TOKEN'], repos, login)
  .questionnaire
  .approved_reviews
  .pull_requests

prs.each do |pr|
  puts pr.html_url
end
