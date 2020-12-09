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

users = User.order(:created_at).take(5)
40.times do
  venue_type = "Coffee Shop"
  category = "Wall Space"
  listing_name = Faker::Restaurant.name
  description = Faker::Lorem.sentence(word_count: 20)
  address = Faker::Address.full_address
  wall_height = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  wall_width = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  price = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  users.each { |user| user.spaces.create!(
    venue_type: venue_type,
    category: category,
    listing_name: listing_name,
    description: description,
    address: address,
    wall_height: wall_height,
    wall_width: wall_width,
    price: price
    ) }
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
