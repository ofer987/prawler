# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.1'

gemspec

# ActiveRecord
gem 'activesupport'

# Project-specific
gem 'octokit', github: 'octokit/octokit.rb', ref: '5b43070', require: true

group :development do
  gem 'guard-bundler'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false

  gem 'pry-byebug'
end

group :development, :test do
  gem 'rspec'
end
