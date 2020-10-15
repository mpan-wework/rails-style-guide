require 'rails_helper'

RSpec.describe RegionClient, type: :feature do
  describe '#regions' do
    it 'returns supported regions' do
      regions = VCR.use_cassette('region/regions', match_requests_on: %i(path query body)) do
        described_class.new.regions
      end

      expect(regions.length).to eq 9
    end
  end

  describe '#region' do
    it 'returns a region' do
      region = VCR.use_cassette('region/region', match_requests_on: %i(path query body)) do
        described_class.new.region code: 'cn'
      end

      expect(region.dig(:phone)).to eq '86'
    end
  end
end
