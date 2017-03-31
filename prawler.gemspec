# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'prawler'

Gem::Specification.new do |spec|
  spec.name          = 'prawler'
  spec.version       = Prawler::VERSION
  spec.authors       = ['Dan Jakob Ofer']
  spec.email         = ['ofer987@gmail.com']

  spec.summary       = 'Display the open Pull Requests'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ofer987/prawler'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'octokit', github: 'octokit/octokit.rb', ref: '5b43070', require: true
end