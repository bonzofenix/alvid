require 'octokit'
require 'alvid/keypair'

class Alvid::Github
  attr_reader :client

  def initialize(api_endpoint, access_token)
    Octokit.configure do |c|
        c.api_endpoint = api_endpoint
    end

    @client = Octokit::Client.new(access_token: access_token)
  end


  def create_repository(repo_name, organization)
    @client.create_repository(repo_name, {:organization=>organization})
    keypair = Alvid::Keypair.new
    @client.add_deploy_key(repo_name, "#{repo_name}-dk", keypair.pub)
    keypair.pri
  end
end
