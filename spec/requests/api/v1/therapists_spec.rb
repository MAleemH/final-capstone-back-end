require 'rails_helper'

RSpec.describe 'Api::V1::Therapists', type: :request do
  before(:each) do
    @user = User.create!(
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: '123456',
      password_confirmation: '123456',
      role: 'admin'
    )
    @therapist = Therapist.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      specialization: Faker::Job.title,
      phone: Faker::PhoneNumber.unique.cell_phone,
      photo: Faker::Internet.url,
      availability: Faker::Boolean.boolean,
      address: Faker::Address.full_address,
      user_id: @user.id
    )
    post '/api/v1/users/sign_in', params: { user: { email: @user.email, password: @user.password } }
    @token = response.headers['Authorization']
  end
  describe 'therapist endpoints' do
    it 'returns all therapists' do
      get "/api/v1/users/#{@user.id}/therapists", headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      get "/api/v1/users/#{@user.id}/therapists", headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe 'therapist show endpoints' do
    it 'returns a therapist' do
      get "/api/v1/users/#{@user['id']}/therapists/#{@therapist['id']}", headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      get "/api/v1/users/#{@user['id']}/therapists/#{@therapist['id']}", headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe 'therapist create endpoints' do
    it 'return successful message if user is admin' do
      @user.update(role: 'admin')
      post "/api/v1/users/#{@user['id']}/therapists", params: { therapist: { name: Faker::Name.name,
                                                                             email: Faker::Internet.unique.email,
                                                                             specialization: Faker::Job.title,
                                                                             phone: Faker::PhoneNumber.unique.cell_phone,
                                                                             photo: Faker::Internet.url,
                                                                             availability: Faker::Boolean.boolean,
                                                                             address: Faker::Address.full_address,
                                                                             user_id: @user.id } }, headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      post "/api/v1/users/#{@user['id']}/therapists", params: { therapist: { name: Faker::Name.name,
                                                                             email: Faker::Internet.unique.email,
                                                                             specialization: Faker::Job.title,
                                                                             phone: Faker::PhoneNumber.unique.cell_phone,
                                                                             photo: Faker::Internet.url,
                                                                             availability: Faker::Boolean.boolean,
                                                                             address: Faker::Address.full_address,
                                                                             user_id: @user.id } }, headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe 'therapist delete endpoints' do
    it 'return successful message if user is admin' do
      @user.update(role: 'admin')
      delete "/api/v1/users/#{@user['id']}/therapists/#{@therapist['id']}", headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      delete "/api/v1/users/#{@user['id']}/therapists/#{@therapist['id']}", headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
