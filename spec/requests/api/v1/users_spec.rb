require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
    before(:each) do
      @user =  User.create!(
        name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        password: "123456",
        password_confirmation: "123456",
        role: 'client'
       )
      post '/api/v1/users/sign_in', params: { user: {email: @user.email, password: @user.password } }
      @token = response.headers['Authorization']
    end
    describe "User index end points" do
      it 'it return all users' do
        get '/api/v1/users/', headers: { 'Authorization': @token }
        expect(response).to have_http_status(:ok)
      end
      it 'it return error message if token is not valid' do
        token= nil
        get '/api/v1/users/', headers: { 'Authorization': token }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    describe "User show end points" do
      it  'it return a user ' do
        get "/api/v1/users/#{@user['id']}", headers: { 'Authorization': @token }
        expect(response).to have_http_status(:ok)
      end
      it 'it return error message if token is not valid' do
        token= nil
        get "/api/v1/users/#{@user['id']}", headers: { 'Authorization': token }
        expect(response).to have_http_status(:unauthorized)
      end
    end
    describe "user destroy end points" do
        it  "it return  successful message if user is admin" do
           @user.update(role: 'admin')
            delete "/api/v1/users/#{@user['id']}", headers: { 'Authorization': @token }
            expect(response).to have_http_status(:ok)
        end
        it "it return  error message if token is not valid" do
          token= nil
          delete "/api/v1/users/#{@user['id']}", headers: { 'Authorization': token }
          expect(response).to have_http_status(:unauthorized)
        end
    end
end
