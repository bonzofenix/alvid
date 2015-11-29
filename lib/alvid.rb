require 'data_mapper'
require 'json'

module Alvid
  def self.init
    db_uri = if ENV['VCAP_SERVICES']
               JSON.parse(ENV['VCAP_SERVICES']).first[1].first.first[1]['uri']
             else
               'sqlite::memory:'
             end
    DataMapper.setup(:default, db_uri)
  end
end

Alvid.init

require "alvid/version"
require "alvid/retro"
