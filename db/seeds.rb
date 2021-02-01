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

25.times do
  user = User.order(:created_at).take(5)[rand(0..4)]
  venue_type = ["Bar","Coffee Shop","Restaurant"].sample
  category = ["Wall Space","Window Display","Entire Gallery"].sample
  listing_name = Faker::Restaurant.name
  description = Faker::Lorem.sentence(word_count: 20)
  address = Faker::Address.full_address
  latitude = rand(51.5..51.52)
  longitude = rand(0.125..0.14)
  wall_height = rand(50..300)
  wall_width = rand(80..200)
  price = Faker::Number.decimal(l_digits: 2, r_digits: 2)
  is_adj_light = rand(0..1)
  is_nat_light = rand(0..1)
  is_dis_acc = rand(0..1)
  is_parking = rand(0..1)
  is_hang_sys = rand(0..1)
  is_plugs = rand(0..1)
  is_sec_sys = rand(0..1)
  is_toilet = rand(0..1)
  is_wifi = rand(0..1)
  is_storage = rand(0..1)
  is_paintings = rand(0..1)
  is_photography = rand(0..1)
  is_drawings = rand(0..1)
  is_sculptures = rand(0..1)
  is_live_perf = rand(0..1)
  is_adverts = rand(0..1)
#  images = Faker::LoremFlickr.image(size: "300x300", search_terms: ['coffee'])
  space = user.spaces.build(
    venue_type: venue_type,
    category: category,
    listing_name: listing_name,
    description: description,
    address: address,
    latitude: latitude,
    longitude: longitude,
    wall_height: wall_height,
    wall_width: wall_width,
    price: price,
    is_adj_light: is_adj_light,
    is_nat_light: is_nat_light,
    is_dis_acc: is_dis_acc,
    is_parking: is_parking,
    is_hang_sys: is_hang_sys,
    is_plugs: is_plugs,
    is_sec_sys: is_sec_sys,
    is_toilet: is_toilet,
    is_wifi: is_wifi,
    is_storage: is_storage,
    is_paintings: is_paintings,
    is_photography: is_photography,
    is_drawings: is_drawings,
    is_sculptures: is_sculptures,
    is_live_perf: is_live_perf,
    is_adverts: is_adverts)
    space.images.attach(
      io: File.open('app/assets/images/exhibition.jpg'),
      filename: 'exhibition.jpg')
      space.save!
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

25.times do
  user = User.order(:created_at).take(5)[rand(0..4)]
  styles = ["Abstract","Realism"].sample
  subject = ["Portrait","Landscape"].sample
  category = ["Advertisement","Drawing","Painting","Photography","Sculpture"].sample
  listing_name = Faker::Hipster.word
  description = Faker::Lorem.sentence(word_count: 20)
  medium = ["Oil on Canvas","Mixed Media"].sample
  height = rand(50..120)
  width = rand(50..120)
  depth = rand(1..3)
  price = rand(10..200)
  year = ["2018","2019","2020"].sample
  status = ["For Sale","Not For Sale","Sold"].sample
  framed = rand(0..1)
  artwork = user.artworks.build(
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
    is_framed: framed,
    price: price)
    artwork.images.attach(
      io: File.open('app/assets/images/skull.jpg'),
      filename: 'skull.jpg')
      artwork.save!
end
