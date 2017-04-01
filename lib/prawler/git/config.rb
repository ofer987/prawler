# frozen_string_literal: true

module Prawler
  module Git
    class Config
      def initialize(cli)
        @cli = cli
      end

      def remotes
        @cli
          .remotes
          .split("\n")
          .map { |line| line.split("\t")[1].split(' ')[0] }
          .map(&:strip)
          .map { |line| line.gsub(/^git@github\.com:/, '') }
          .map { |line| line.gsub(/\.git$/, '') }
          .uniq
      end
    end
  end
end
