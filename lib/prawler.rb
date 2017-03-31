# frozen_string_literal: true

require 'active_support'
require 'active_support/logger'
require 'active_support/core_ext'

require_relative 'prawler/version'

module Prawler
  require_relative 'prawler/main'
  require_relative 'prawler/questionnaire'
end
