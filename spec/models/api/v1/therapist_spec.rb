require  'rails_helper'

RSpec.describe  Therapist, type: :model do
  before(:each) do
    @user =  User.create!(
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: "123456",
      password_confirmation: "123456",
      role: ['client','admin'].sample
     )
     @therapist = Therapist.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      specialization: Faker::Job.title,
      phone: Faker::PhoneNumber.unique.cell_phone,
      photo: Faker::Internet.url,
      availability: Faker::Boolean.boolean,
      address: Faker::Address.full_address,
      user_id: User.all.sample.id
    )
   end
  it "is valid with valid attributes" do
    expect(@therapist).to be_valid
  end
 
end