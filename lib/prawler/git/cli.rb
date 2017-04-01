# frozen_string_literal: true

module Prawler
  module Git
    class Cli
      def remotes
        `git remote -v`
      end

      def config_list
        `git config --list`
      end
    end
  end
end
