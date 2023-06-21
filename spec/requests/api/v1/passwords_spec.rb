require 'rails_helper'

RSpec.describe 'Api::V1::Passwords', type: :request do
  before(:each) do
    @user = User.create!(
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: '123456',
      password_confirmation: '123456',
      role: 'client'
    )
  end
  describe 'User forgot password end points' do
    it 'it return error message if email is not valid', :show_in_doc do
      put '/api/v1/users/password', params: { user: { email: @user.email, password: '1234567', password_confirmation: '1234567' } }
      expect(response).to have_http_status(:ok)
    end
    it 'it return error message if email is not valid', :show_in_doc do
      put '/api/v1/users/password', params: { user: { email: 'z@gmail.com', password: '1234567', password_confirmation: '1234567' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
