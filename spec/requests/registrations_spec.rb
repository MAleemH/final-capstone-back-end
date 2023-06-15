require 'rails_helper'

RSpec.describe 'Api::V1::Registrations', type: :request do
  describe 'User create end points' do
    it 'it return created user with valid token' do
      post '/api/v1/users/',
           params: { user: { name: Faker::Name.unique.name, email: Faker::Internet.unique.email, password: '123456', password_confirmation: '123456',
                             role: %w[client admin].sample } }
      expect(response).to have_http_status(:created)
    end
    it 'it return error message if one parameter is not valid' do
      post '/api/v1/users/',
           params: { user: { email: Faker::Internet.unique.email, password: '123456', password_confirmation: '123456',
                             role: %w[client admin].sample } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
