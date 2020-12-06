# Create main test user
User.create!(firstname: "Test", lastname: "User", email: "test@testuser.com", password: "password123", password_confirmation: "password123", admin: true)

# Bulk generate test users
99.times do |n|
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = "example-#{n+1}@testuser.com"
  password = "password123"
  User.create!(firstname: firstname, lastname: lastname, email: email, password: password, password_confirmation: password)
end
