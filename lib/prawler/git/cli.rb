# frozen_string_literal: true

module Prawler
  module Git
    class Cli
      def remotes
        `git remote -v`
      end
    end
  end
end
