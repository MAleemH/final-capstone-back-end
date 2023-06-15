require 'rails_helper'

RSpec.describe 'Api::V1::Appointments', type: :request do
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
    @appointment = Appointment.create!(
      date: Faker::Date.forward(days: 23),
      user_id: @user.id,
      therapist_id: @therapist.id
    )
    post '/api/v1/users/sign_in', params: { user: { email: @user.email, password: @user.password } }
    @token = response.headers['Authorization']
  end
  describe 'appointment endpoints' do
    it 'returns all appointments' do
      get "/api/v1/users/#{@user['id']}/appointments", headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      get "/api/v1/users/#{@user['id']}/appointments", headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe 'appointment show endpoints' do
    it 'returns a appointment' do
      get "/api/v1/users/#{@user['id']}/appointments/#{@appointment['id']}", headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      get "/api/v1/users/#{@user['id']}/appointments/#{@appointment['id']}", headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe 'appointment create endpoints' do
    it 'return successful message if user is admin' do
      @user.update(role: 'admin')
      post "/api/v1/users/#{@user['id']}/appointments", params: { appointment: { date: Faker::Date.forward(days: 23),
                                                                                 user_id: @user.id,
                                                                                 therapist_id: @therapist.id } }, headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      post "/api/v1/users/#{@user['id']}/appointments", params: { appointment: { date: Faker::Date.forward(days: 23),
                                                                                 user_id: @user.id,
                                                                                 therapist_id: @therapist.id } }, headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
  describe 'appointment destroy endpoints' do
    it 'returns successful message if user is admin' do
      @user.update(role: 'admin')
      delete "/api/v1/users/#{@user['id']}/appointments/#{@appointment['id']}", headers: { Authorization: @token }
      expect(response).to have_http_status(:success)
    end
    it 'returns error message if token is not valid' do
      token = nil
      delete "/api/v1/users/#{@user['id']}/appointments/#{@appointment['id']}", headers: { Authorization: token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
