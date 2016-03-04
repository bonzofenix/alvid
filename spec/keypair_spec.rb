require 'octokit'
require 'alvid/keypair'

describe Alvid::Keypair do
  let(:keypair) { described_class.new }

  describe 'new' do
    it 'should generate new sshkey'  do
      expect(SSHKey).to receive(:generate)
      keypair
    end
  end

  describe 'pri' do
    it 'should return private key' do
      expect_any_instance_of(SSHKey).to receive(:private_key)
      keypair.pri
    end
  end

  describe 'pub' do
    it 'should return public key' do
      expect_any_instance_of(SSHKey).to receive(:public_key)
      keypair.pub
    end
  end
end
