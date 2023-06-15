require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: '123456',
      password_confirmation: '123456',
      role: %w[client admin].sample
    )
  end
  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end
  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end
  it 'is not valid without a email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end
  it 'is not valid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end
  it 'is not valid without a role' do
    @user.role = nil
    expect(@user).to_not be_valid
  end
end
