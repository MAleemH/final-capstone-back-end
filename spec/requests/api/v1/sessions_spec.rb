require 'rails_helper'
​
RSpec.describe 'Api::V1::Sessions', type: :request do
  describe "User login end points" do
    before(:each) do
      @user =  User.create!(
        name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        password: "123456",
        password_confirmation: "123456",
        role: ['client','admin'].sample
       )
    end
    describe "User login end points" do
      it 'it return user with valid token' do
        post '/api/v1/users/sign_in', params: { user: {email: @user.email, password: @user.password } }
        expect(response).to have_http_status(:created)
      end
      it 'it return error message if one parameter is not valid' do
        post '/api/v1/users/sign_in', params: { user: {email: @user.email, password: "1234567"} }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    
  end
end