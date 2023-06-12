# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])

#   Character.create(name: "Luke", movie: movies.first)
# Create users
# Assuming you have the necessary models defined (User, Therapist, Appointment)

# Create mock users
User.create(name: "John Doe", email: "john@example.com")
User.create(name: "Jane Smith", email: "jane@example.com")

# Create mock therapists
Therapist.create(name: "Dr. Sarah Johnson", email: "sarah@example.com", specialization: "Psychology", phone: "1234567890", photo: "http://example.com/photo.jpg", availability: true, address: "123 Main St", user_id: 1)
Therapist.create(name: "Dr. David Wilson", email: "david@example.com", specialization: "Counseling", phone: "9876543210", photo: "http://example.com/photo2.jpg", availability: false, address: "456 Elm St", user_id: 2)

# Create mock appointments
Appointment.create(date: "2023-06-10", user_id: 1, therapist_id: 1)
Appointment.create(date: "2023-06-12", user_id: 2, therapist_id: 2)


