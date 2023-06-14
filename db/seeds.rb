# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Appointment.destroy_all
Therapist.destroy_all
User.destroy_all

# create users account

4.times do
   User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "123456",
    password_confirmation: "123456",
    role: ['client','admin'].sample
   )
end

4.times do
    Therapist.create!(
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

4.times do
    Appointment.create!(
      date: Faker::Date.between(from: '2021-01-01', to: '2021-12-31'),
      status: 'scheduled',
      user_id: User.all.sample.id,
      therapist_id: Therapist.all.sample.id
    )
end
