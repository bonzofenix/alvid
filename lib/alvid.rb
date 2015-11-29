require 'data_mapper'
require 'json'

module Alvid
  def self.init
    db_uri = if ENV['VCAP_SERVICES'].nil? || JSON.parse(ENV['VCAP_SERVICES']).empty?
                require 'dm-sqlite-adapter'
               'sqlite::memory:'
             else
               require 'dm-mysql-adapter'
               product_name, service = JSON.parse(ENV['VCAP_SERVICES']).first
               case product_name
                 when /mysql/
                   service.first.first[1]['uri']
                 when /cleardb/
                   service.first['credentials']['uri']
               end
             end
    DataMapper.setup(:default, db_uri)
  end
end

Alvid.init

require "alvid/version"
require "alvid/retro"
