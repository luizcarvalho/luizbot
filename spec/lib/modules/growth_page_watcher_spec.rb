require 'spec_helper'

RSpec.describe 'GrowthPageWatcher' do
  let(:growth_page_watcher) { GrowthPageWatcher.new }

  describe 'fetch_nokogiri_page' do
    it 'returns a Nokogiri::HTML::Document' do
      expect(growth_page_watcher.doc).to be_a Nokogiri::HTML::Document
    end
    describe 'verify' do
      it 'returns false if the item is unavailable' do
        expect(growth_page_watcher.verify).to be false
      end
    end
  end
end
