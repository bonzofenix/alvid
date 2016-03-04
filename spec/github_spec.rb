require 'spec_helper'
require 'byebug'

describe Alvid::Github do
  let(:access_token){ 'bar' }
  let(:organization){ 'compozed' }
  let(:repo_name){ 'banana' }
  let(:keypair){ double('keypair', pub: 'public-key', pri: 'private-key') }
  let(:api_endpoint){ 'https://myenterprise.github.com/api/v3/' }
  let(:github){ Alvid::Github.new(api_endpoint, access_token)}

  describe 'new' do
    it 'should login application' do
      expect(Octokit::Client).to receive(:new).with(access_token: access_token)
      github
    end

    it 'should set api_endpoint' do
      expect(github.client.api_endpoint).to eq(api_endpoint)
    end
  end

  describe 'create_repository' do
    before do
      allow(Alvid::Keypair).to receive(:new).and_return(keypair)
      allow_any_instance_of(Octokit::Client).to receive(:create_repository)
      allow_any_instance_of(Octokit::Client).to receive(:add_deploy_key)
    end

    it 'should create a github' do
      expect_any_instance_of(Octokit::Client).to receive(:create_repository).with(repo_name, organization: organization)
      github.create_repository(repo_name, organization)
    end

    it 'should upload public key' do
      expect_any_instance_of(Octokit::Client).to receive(:add_deploy_key).with("#{organization}/#{repo_name}", "#{repo_name}-dk", keypair.pub )
      github.create_repository(repo_name, organization)
    end

    it 'should return private key' do
      expect(github.create_repository(repo_name, organization)).to eq(keypair.pri)
    end
  end
end
