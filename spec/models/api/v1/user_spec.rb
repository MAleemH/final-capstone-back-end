require 'rails_helper'

RSpec.describe User, type: :model do
     before(:each) do
      @user =  User.create!(
        name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        password: "123456",
        password_confirmation: "123456",
        role: ['client','admin'].sample
       )
     end
   it "is valid with valid attributes" do
      expect(@user).to be_valid
   end
   
end