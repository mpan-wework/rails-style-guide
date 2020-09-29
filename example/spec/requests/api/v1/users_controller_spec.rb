require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:body) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET /api/v1/firms/:firm_uuid/users' do
    let(:firm) { create(:firm).reload }

    it 'returns all users under firm' do
      create_list :user, 4, firm: firm

      get "/api/v1/firms/#{firm.uuid}/users"

      expect(response).to have_http_status(200)
      expect(body.length).to eq 4
    end
  end

  describe 'GET /api/v1/users/:uuid' do
    it 'returns a firm' do
      user = create(:user).reload

      get "/api/v1/users/#{user.uuid}"

      expect(response).to have_http_status 200
      expect(body.dig(:email)).to eq user.email
    end

    it 'returns unknown user' do
      get "/api/v1/users/#{SecureRandom.uuid}"

      expect(response).to have_http_status 404
      expect(body.dig(:message).nil?).to be false
    end
  end

  describe 'POST /api/v1/firms/:firm_uuid/users' do
    let(:firm) { create(:firm).reload }

    context 'with valid params' do
      let(:params) do
        {
          user: {
            name: 'Mike Pan',
            email: 'mike.pan@wework.com',
            phone: '13803110427'
          }
        }
      end

      it 'creates a user' do
        post "/api/v1/firms/#{firm.uuid}/users", params: params

        expect(response).to have_http_status 201
        expect(body.dig(:email)).to eq params.dig(:user, :email)
      end
    end

    context 'with unknown firm' do
      let(:params) do
        {
          user: {
            name: 'Mike Pan',
            email: 'mike.pan@wework.com',
            phone: '13803110427'
          }
        }
      end

      it 'fails to create a user' do
        post "/api/v1/firms/#{SecureRandom.uuid}/users", params: params

        expect(response).to have_http_status 404
        expect(body.dig(:message).nil?).to be false
      end
    end

    context 'with invalid params' do
      let(:params) { { user: {} } }

      it 'fails to create a user' do
        post "/api/v1/firms/#{firm.uuid}/users", params: params

        expect(response).to have_http_status 400
        expect(body.dig(:message).nil?).to be false
      end
    end
  end

  describe 'PATCH /api/v1/users/:uuid' do
    let(:user) { create(:user).reload }

    context 'with valid params' do
      let(:params) do
        { user: { name: 'Monkey King' } }
      end

      it 'updates a user' do
        patch "/api/v1/users/#{user.uuid}", params: params

        expect(response).to have_http_status 200
        expect(body.dig(:name)).to eq params.dig(:user, :name)
      end
    end

    context 'with invalid params' do
      let(:params) { { user: { name: '' } } }

      it 'fails to update a user' do
        patch "/api/v1/users/#{user.uuid}", params: params

        expect(response).to have_http_status 422
        expect(body.dig(:name)).to include "can't be blank"
      end
    end
  end
end
