#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/environment'

prs = Main
  .new(ENV['TOKEN'])
  .questions
  .open
  .approved_reviews
  .pull_requests

prs.each do |pr|
  puts pr.number
end
