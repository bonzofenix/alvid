$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'factory_girl'
require 'alvid'

RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
    config.before(:suite) { FactoryGirl.reload }
    config.before(:each) { DataMapper.auto_migrate!  }
end

