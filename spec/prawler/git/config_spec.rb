# frozen_string_literal: true

require 'pry-byebug'
require 'rspec'
require_relative '../../../lib/prawler/git/cli'
require_relative '../../../lib/prawler/git/config'

describe Prawler::Git::Config do
  before do
    allow(cli)
      .to receive(:remotes)
      .and_return(remote_output)
  end

  let(:remote_output) do
    <<~OUTPUT
      origin	git@github.com:ofer987/octokit.rb.git (fetch)
      origin	git@github.com:ofer987/octokit.rb.git (push)
      upstream	git@github.com:octokit/octokit.rb.git (fetch)
      upstream	git@github.com:octokit/octokit.rb.git (push)
    OUTPUT
  end
  let(:cli) { Prawler::Git::Cli.new }

  describe '#remotes' do
    subject { described_class.new(cli).remotes }

    it { is_expected.to eq %w[ofer987/octokit.rb octokit/octokit.rb] }
  end
end
