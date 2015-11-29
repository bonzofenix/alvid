require 'spec_helper'

describe Alvid do
  it 'has a version number' do
    expect(Alvid::VERSION).not_to be nil
  end

  describe 'init' do
    describe 'when VCAP_SERVICES provided' do
      it 'uses provided db' do
        ENV["VCAP_SERVICES"] = '{ "p-mysql-n/a": [ { "credentials": { "uri":"cool-mysql-uri" }, "label": "p-mysql-n/a", "name": "p-mysql", "syslog_drain_url": "", "tags": ["postgres","postgresql","relational"] } ] } '
        expect(DataMapper).to receive(:setup).with(:default, "cool-mysql-uri")
        Alvid.init
        ENV.clear
      end
    end

    describe 'when VCAP_SERVICES is empty' do
      it 'uses provided db' do
        ENV["VCAP_SERVICES"] = '{  }'
        expect(DataMapper).to receive(:setup).with(:default, 'sqlite::memory:')
        Alvid.init
        ENV.clear
      end
    end

    describe "when VCAP_SERVICES is not provided" do
      it "uses inmemory db" do
        ENV.clear
        expect(DataMapper).to receive(:setup).with(:default, 'sqlite::memory:')
        Alvid.init
      end
    end
  end
end
