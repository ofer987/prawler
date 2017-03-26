# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.1'

# ActiveRecord
gem 'activesupport'

# Project-specific
gem 'octokit', github: 'octokit/octokit.rb', require: true

group :development do
  gem 'guard-bundler'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false

  gem 'pry-byebug'
end

group :development, :test do
  gem 'rspec'
end
