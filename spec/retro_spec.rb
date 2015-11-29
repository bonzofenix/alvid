require 'spec_helper'

describe Alvid::Retro do
  describe 'add' do
    it 'creates a retro item' do
      expect{
        Alvid::Retro.add 'banana'
      }.to change{ described_class.count }.by(1)
    end
  end

  describe 'list' do
    before do
      create(:retro, message: 'banana 1')
      create(:retro, message: 'banana 2')
    end

    it 'show all retro items' do
      expect( Alvid::Retro.list).to eq("banana 1\nbanana 2")
    end
  end

  describe 'clear' do
    before do
      create(:retro, message: 'banana 1')
      create(:retro, message: 'banana 2')
    end

    it 'clear all retro items' do
      expect{
        Alvid::Retro.clear
      }.to change{ described_class.count }.to(0)
    end
  end
end
