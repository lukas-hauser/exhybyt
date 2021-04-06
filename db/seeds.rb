require 'csv'

CSV.foreach(Rails.root.join('lib/seed_csv/faqs.csv'), headers: true) do |row|
  Faq.create( {
    question: row["Question"],
    answer: row["Answer"],
    category: row["Category"],
  } )
end

styles = ["Abstract",
  "Abstract Expressionism",
  "Art Deco",
  "Conceptual",
  "Cubism",
  "Dada",
  "Documentary",
  "Expressionism",
  "Figurative",
  "Fine Art",
  "Folk",
  "Illustration",
  "Impressionism",
  "Minimalism",
  "Modern",
  "Photorealism",
  "Pop Art",
  "Portraiture",
  "Realism",
  "Street Art",
  "Surrealism"]

venue_types = ["Airport",
  "Architecture Firm",
  "Art Gallery",
  "Art Supply Store",
  "Bank",
  "Bar",
  "Barber",
  "Book Store",
  "Charity",
  "Church",
  "City Office",
  "Coffee Shop",
  "Convention Center",
  "Hair Saloon",
  "Hospital",
  "Hotel",
  "Interior Designer",
  "Law Office",
  "Library",
  "Market Stall",
  "PopUp Space",
  "Private Members Club",
  "Restaurant",
  "University",
  "Other"]

artwork_subjects = ["Abstract",
  "Aerial",
  "Airplane",
  "Animal",
  "Architecture",
  "Automobile",
  "Beach",
  "Bicycle",
  "Bike",
  "Boat",
  "Body",
  "Botanic",
  "Business",
  "Calligraphy",
  "Car",
  "Cartoon",
  "Cats",
  "Celebrity",
  "Children",
  "Cinema",
  "Cities",
  "Cityscape",
  "Classical Mythology",
  "Comics",
  "Cows",
  "Cuisine",
  "Culture",
  "Dogs",
  "Education",
  "Erotic",
  "Family",
  "Fantasy",
  "Fashion",
  "Fish",
  "Floral",
  "Food",
  "Food & Drink",
  "Garden",
  "Geometric",
  "Graffiti",
  "Health & Beauty",
  "Home",
  "Horse",
  "Humour",
  "Interiors",
  "Kids",
  "Kitchen",
  "Landscape",
  "Language",
  "Light",
  "Love",
  "Men",
  "Mortality",
  "Motor",
  "Motorbike",
  "Motorcycle",
  "Music",
  "Nature",
  "Nude",
  "Outer Space",
  "Patterns",
  "People",
  "Performing Arts",
  "Places",
  "Political",
  "Politics",
  "Pop Culture",
  "Portrait",
  "Religion",
  "Rural Life",
  "Sailboat",
  "Science",
  "Seascape",
  "Seasons",
  "Ship",
  "Sports",
  "Still Life",
  "Technology",
  "Time",
  "Train",
  "Transportation",
  "Travel",
  "Tree",
  "Typography",
  "Wall",
  "Water",
  "Women",
  "World Culture",
  "Yacht"]

artwork_materials = [ "Paper",
  "Canvas"
]

artwork_mediums = [ "Oil",
  "Acrylyc"
]

space_images = [
  "https://images.unsplash.com/photo-1463797221720-6b07e6426c24?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80",
  "https://images.unsplash.com/photo-1445116572660-236099ec97a0?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80",
  "https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1357&q=80",
  "https://images.unsplash.com/photo-1514371879740-2e7d2068f502?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1267&q=80",
  "https://images.unsplash.com/photo-1453614512568-c4024d13c247?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1189&q=80",
  "https://images.unsplash.com/photo-1494346480775-936a9f0d0877?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1303&q=80",
  "https://images.unsplash.com/photo-1505275350441-83dcda8eeef5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80",
  "https://images.unsplash.com/photo-1522008174174-1a7e4c12078f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80",
  "https://images.unsplash.com/photo-1511081692775-05d0f180a065?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=933&q=80",
  "https://images.unsplash.com/photo-1533630757306-cbadb934bcb1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1529417305485-480f579e7578?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1409&q=80",
  "https://images.unsplash.com/photo-1512192397443-4fd4ed400de3?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1513267048331-5611cad62e41?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1508766917616-d22f3f1eea14?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1515215234071-62cca5638e20?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80",
  "https://images.unsplash.com/photo-1517638851339-a711cfcf3279?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
]

artwork_images =[
  "https://i0.wp.com/lukashauser.art/wp-content/uploads/2017/08/Give-Me-a-Reason-e1504438812511.jpg",
  "https://i0.wp.com/lukashauser.art/wp-content/uploads/2017/01/33611235923_912ff1bcc7_o-e1504360657215.jpg?fit=957%2C1090",
  "https://i2.wp.com/lukashauser.art/wp-content/uploads/2017/06/25063600611_8f1861b44c_b.jpg?fit=957%2C1090",
  "https://i2.wp.com/lukashauser.art/wp-content/uploads/2017/01/Umbrellas.jpg?fit=957%2C1090",
  "https://i2.wp.com/lukashauser.art/wp-content/uploads/2017/01/Beach-Vibes-in-the-City-1-e1504464826324.jpg?fit=957%2C1090",
  "https://i2.wp.com/lukashauser.art/wp-content/uploads/2019/04/Thunderstruck-e1554675695591.jpg?fit=957%2C1090",
  "https://i1.wp.com/lukashauser.art/wp-content/uploads/2019/02/Peace-Burial-at-Sea-e1549673688333.jpg?fit=957%2C1090",
  "https://i0.wp.com/lukashauser.art/wp-content/uploads/2019/02/Lit-e1549673663233.jpg?fit=957%2C1090",
  "https://i0.wp.com/lukashauser.art/wp-content/uploads/2019/02/Skull-of-a-Skeleton-with-Burning-Cigarette-e1549673637489.jpg?fit=957%2C1090",
  "https://i1.wp.com/lukashauser.art/wp-content/uploads/2019/02/Contemporary-Henry-VIII-e1549673763285.jpg?fit=957%2C1090",
  "https://i1.wp.com/lukashauser.art/wp-content/uploads/2019/03/Metamorphosis-of-Narcissus-e1551646196169.jpg?fit=957%2C1090",
  "https://i2.wp.com/lukashauser.art/wp-content/uploads/2019/02/Exploding-Sunflower-Vase-e1549673856443.jpg?fit=957%2C1090",
  "https://i1.wp.com/lukashauser.art/wp-content/uploads/2019/02/Escaping-the-Gilded-Cage-e1549753597357.jpg?fit=957%2C1090",
  "https://i2.wp.com/lukashauser.art/wp-content/uploads/2017/01/Hamster-Wheel-Painting-scaled.jpg?fit=957%2C1090"]

styles.each do |style|
  Style.create!(name: style)
end

#venue_types.each do |venue_type|
#  Type.create!(name: venue_type)
#end

#artwork_subjects.each do |artwork_subject|
#  Subject.create!(name: artwork_subject)
#end

#artwork_materials.each do |artwork_material|
#  Material.create!(name: artwork_material)
#end

#artwork_mediums.each do |artwork_medium|
#  Medium.create!(name: artwork_medium)
#end

# Create main test user
User.create!(firstname: "Test",
  lastname: "User", email: "test@testuser.com",
  password: "password123",
  password_confirmation: "password123",
  admin: true,
  currency: "gbp",
  activated: true,
  activated_at: Time.zone.now)

# Create non-admin demo user
User.create!(firstname: "Demo",
  lastname: "User", email: "demo@demouser.com",
  password: "exhybyt",
  password_confirmation: "exhybyt",
  currency: "gbp",
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
    currency: "gbp",
    activated: true,
    activated_at: Time.zone.now)
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

25.times do
  user = User.order(:created_at).take(5)[rand(0..4)]
  style_ids = [Style.first.id, Style.second.id]
  subject = artwork_subjects.sample
  category = ["Advertisement","Drawing","Painting","Photography","Sculpture"].sample
  listing_name = Faker::Artist.name
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
    style_ids: style_ids,
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
      io: URI.open(artwork_images.sample),
      filename: 'photo.jpg',
      content_type: 'image/jpg')
    artwork.save!
end

space_n = 1
25.times do
  user = User.order(:created_at).take(5)[rand(0..4)]
  venue_type      = venue_types.sample
  category        = ["Wall Space","Window Display","Entire Gallery"].sample
  listing_name    = "Sample Space #{space_n}" # Faker::Restaurant.name
  description     = "This is the description of a sample space. This space can't be booked."# Faker::Lorem.sentence(word_count: 20)
  address         = "London #{["W1","SW1","WC1","WC2","EC1","EC2","EC3"].sample} #{rand(1..9)}#{('A'..'Z').to_a[rand(26)]}"
  latitude        = rand(51.5..51.51) # Geocoder.search(address).first.latitude
  longitude       = rand(-0.12..-0.115) # Geocoder.search(address).first.longitude
  wall_height     = rand(50..300)
  wall_width      = rand(80..200)
  price           = rand(5.00..100.00)
  days_min        = rand(1..7)
  is_adj_light    = rand(0..1)
  is_nat_light    = rand(0..1)
  is_dis_acc      = rand(0..1)
  is_parking      = rand(0..1)
  is_hang_sys     = rand(0..1)
  is_plugs        = rand(0..1)
  is_sec_sys      = rand(0..1)
  is_toilet       = rand(0..1)
  is_wifi         = rand(0..1)
  is_storage      = rand(0..1)
  is_paintings    = rand(0..1)
  is_photography  = rand(0..1)
  is_drawings     = rand(0..1)
  is_sculptures   = rand(0..1)
  is_live_perf    = rand(0..1)
  is_adverts      = rand(0..1)
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
    days_min: days_min,
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
      io: URI.open(space_images.sample),
      filename: 'photo.jpg',
      content_type: 'image/jpg')
    space.save!
    space_n += 1
end
