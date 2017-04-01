# frozen_string_literal: true

require 'pry-byebug'
require 'rspec'
require_relative '../../../lib/prawler/git/cli'
require_relative '../../../lib/prawler/git/config'

describe Prawler::Git::Config do
  let(:cli) { Prawler::Git::Cli.new }

  describe '#remotes' do
    before do
      allow(cli)
        .to receive(:remotes)
        .and_return(remote_output)
    end

    subject { described_class.new(cli).remotes }
    let(:remote_output) do
      <<~OUTPUT
        origin	git@github.com:ofer987/octokit.rb.git (fetch)
        origin	git@github.com:ofer987/octokit.rb.git (push)
        upstream	git@github.com:octokit/octokit.rb.git (fetch)
        upstream	git@github.com:octokit/octokit.rb.git (push)
      OUTPUT
    end

    it { is_expected.to eq %w[ofer987/octokit.rb octokit/octokit.rb] }
  end

  describe '#prawler_token' do
    before do
      allow(cli)
        .to receive(:config_list)
        .and_return(output)
    end

    subject { described_class.new(cli).prawler_token }
    let(:output) do
      <<~OUTPUT
        credential.helper=osxkeychain
        user.name=Sir Bar
        user.email=thomas@tidmouthsheds.co.uk
        prawler.token=ffffff48ceeeb47uuuuuuuuuuuuu
        core.repositoryformatversion=0
        core.filemode=true
        core.bare=false
      OUTPUT
    end

    it { is_expected.to eq('ffffff48ceeeb47uuuuuuuuuuuuu') }
  end
end
