require 'sshkey'

module Alvid
  class Keypair
    def initialize
      @keypair = SSHKey.generate
    end

    def pub
      @keypair.public_key
    end
    def pri
      @keypair.private_key
    end
  end

end
