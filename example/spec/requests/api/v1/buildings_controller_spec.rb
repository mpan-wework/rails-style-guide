require 'rails_helper'

RSpec.describe Api::V1::BuildingsController, type: :request do
  let(:body) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET /api/v1/buildings' do
    it 'returns all buildings' do
      create_list :building, 2

      get '/api/v1/buildings'

      expect(response).to have_http_status 200
      expect(body.length).to eq 2
    end
  end

  describe 'GET /api/v1/buildings/:uuid' do
    it 'returns a building' do
      building = create(:building).reload

      get "/api/v1/buildings/#{building.uuid}"

      expect(response).to have_http_status 200
      expect(body.dig(:name)).to eq building.name
    end

    it 'returns unknown building' do
      get "/api/v1/buildings/#{SecureRandom.uuid}"

      expect(response).to have_http_status 404
      expect(body.dig(:message).nil?).to be false
    end
  end

  describe 'POST /api/v1/buildings' do
    context 'with valid params' do
      let(:params) do
        { building: { name: 'WeWork HQ' } }
      end

      it 'creates a building' do
        post '/api/v1/buildings', params: params

        expect(response).to have_http_status 201
        expect(body.dig(:name)).to eq params.dig(:building, :name)
      end
    end

    context 'with invalid params' do
      let(:params) { { building: {} } }

      it 'fails to create a building' do
        post '/api/v1/buildings', params: params

        expect(response).to have_http_status 400
        expect(body.dig(:message).nil?).to be false
      end
    end
  end

  describe 'PATCH /api/v1/buildings/:uuid' do
    let(:building) { create(:building).reload }

    context 'with valid params' do
      let(:params) do
        { building: { name: 'Github HQ' } }
      end

      it 'updates a building' do
        patch "/api/v1/buildings/#{building.uuid}", params: params

        expect(response).to have_http_status 200
        expect(body.dig(:name)).to eq params.dig(:building, :name)
      end
    end

    context 'with invalid params' do
      let(:params) { { building: { name: '' } } }

      it 'fails to update a building' do
        patch "/api/v1/buildings/#{building.uuid}", params: params

        expect(response).to have_http_status 422
        expect(body.dig(:name)).to include "can't be blank"
      end
    end
  end
end
