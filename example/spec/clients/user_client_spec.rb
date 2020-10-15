require 'rails_helper'

RSpec.describe UserClient, type: :feature do
  describe '#info' do
    it 'returns user\'s info' do
      user = VCR.use_cassette('user/info', match_requests_on: %i(path query body)) do
        UserClient.new.info user_id: 1
      end
      expect(user.dig(:name)).to eq 'Leanne Graham'
    end
  end

  describe '#firm' do
    it 'returns user\'s firm' do
      firm = VCR.use_cassette('user/firm', match_requests_on: %i(path query body)) do
        UserClient.new.firm user_id: 2
      end
      expect(firm.dig(:name)).to eq 'Deckow-Crist'
    end
  end

  describe '#posts' do
    it 'returns user\'s posts' do
      posts = VCR.use_cassette('user/posts', match_requests_on: %i(path query body)) do
        UserClient.new.posts user_id: 3
      end
      expect(posts.length).to eq 10
    end
  end
end
