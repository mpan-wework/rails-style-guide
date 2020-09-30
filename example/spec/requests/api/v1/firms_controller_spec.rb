require 'rails_helper'

RSpec.describe Api::V1::FirmsController, type: :request do
  let(:body) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET /api/v1/buildings/:building_uuid/firms' do
    let(:building) { create(:building).reload }

    it 'returns all firms under building' do
      create_list :firm, 3, building: building

      get "/api/v1/buildings/#{building.uuid}/firms"

      expect(response).to have_http_status(200)
      expect(body.length).to eq 3
    end
  end

  describe 'GET /api/v1/firms/:uuid' do
    it 'returns a firm' do
      firm = create(:firm).reload

      get "/api/v1/firms/#{firm.uuid}"

      expect(response).to have_http_status 200
      expect(body.dig(:name)).to eq firm.name
    end

    it 'returns unknown firm' do
      get "/api/v1/firms/#{SecureRandom.uuid}"

      expect(response).to have_http_status 404
      expect(body.dig(:message).nil?).to be false
    end
  end

  describe 'POST /api/v1/buildings/:building_uuid/firms' do
    let(:building) { create(:building).reload }

    context 'with valid params' do
      let(:params) do
        { firm: { name: 'The We Company' } }
      end

      it 'creates a firm' do
        post "/api/v1/buildings/#{building.uuid}/firms", params: params

        expect(response).to have_http_status 201
        expect(body.dig(:name)).to eq params.dig(:firm, :name)
      end
    end

    context 'with unknown building' do
      let(:params) do
        { firm: { name: 'The We Company' } }
      end

      it 'fails to create a firm' do
        post "/api/v1/buildings/#{SecureRandom.uuid}/firms", params: params

        expect(response).to have_http_status 404
        expect(body.dig(:message).nil?).to be false
      end
    end

    context 'with invalid params' do
      let(:params) { { firm: {} } }

      it 'fails to create a firm' do
        post "/api/v1/buildings/#{building.uuid}/firms", params: params

        expect(response).to have_http_status 400
        expect(body.dig(:message).nil?).to be false
      end
    end
  end

  describe 'PATCH /api/v1/firms/:uuid' do
    let(:firm) { create(:firm).reload }

    context 'with valid params' do
      let(:params) do
        { firm: { name: 'TikTok' } }
      end

      it 'updates a firm' do
        patch "/api/v1/firms/#{firm.uuid}", params: params

        expect(response).to have_http_status 200
        expect(body.dig(:name)).to eq params.dig(:firm, :name)
      end
    end

    context 'with invalid params' do
      let(:params) { { firm: { name: '' } } }

      it 'fails to update a firm' do
        patch "/api/v1/firms/#{firm.uuid}", params: params

        expect(response).to have_http_status 422
        expect(body.dig(:name)).to include "can't be blank"
      end
    end
  end
end
