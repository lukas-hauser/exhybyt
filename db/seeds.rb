# Create main test user
User.create!(firstname: "Test",
  lastname: "User", email: "test@testuser.com",
  password: "password123",
  password_confirmation: "password123",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

# Bulk generate test users
99.times do |n|
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = "example-#{n+1}@testuser.com"
  password = "password123"
  User.create!(firstname: firstname,
    lastname: lastname,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

users = User.order(:created_at).take(5)
5.times do
  venue_type = "Coffee Shop"
  category = "Wall Space"
  listing_name = Faker::Restaurant.name
  description = Faker::Lorem.sentence(word_count: 20)
  address = Faker::Address.full_address
  latitude = Faker::Address.latitude
  longitude = Faker::Address.longitude
  wall_height = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  wall_width = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  price = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  images = Faker::LoremFlickr.image(size: "300x300", search_terms: ['coffee'])
  users.each { |user| space = user.spaces.build(
    venue_type: venue_type,
    category: category,
    listing_name: listing_name,
    description: description,
    address: address,
    latitude: latitude,
    longitude: longitude,
    wall_height: wall_height,
    wall_width: wall_width,
    price: price)
    space.images.attach(
      io: File.open('app/assets/images/exhibition.jpg'),
      filename: 'exhibition.jpg')
      space.save!
    }
end

users = User.order(:created_at).take(5)
5.times do
  styles = "Realism"
  subject = "Portrait"
  category = "Painting"
  listing_name = Faker::Hipster.word
  description = Faker::Lorem.sentence(word_count: 20)
  medium = "Oil on Canvas"
  height = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  width = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  depth = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  price = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  year = "2020"
  status = "For Sale"
  users.each { |user| artwork = user.artworks.build(
    styles: styles,
    subject: subject,
    category: category,
    listing_name: listing_name,
    description: description,
    medium: medium,
    height: height,
    width: width,
    depth: depth,
    year: year,
    status: status,
    price: price)
    artwork.images.attach(
      io: File.open('app/assets/images/skull.jpg'),
      filename: 'skull.jpg')
      artwork.save!
    }
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
