require 'faker'

# Create Users
5.times do
  user = User.new(
    name:       Faker::Name.name,
    username:   Faker::Lorem.characters(5),
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10) 
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis
5.times do
  Wiki.create!(
    title:       Faker::Lorem.sentence(2),
    description: Faker::Lorem.sentence(5),
    owner: users.sample
    )
end
wikis = Wiki.all

# Create Pages
20.times do 
  page = Page.create!(
    wiki:  wikis.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
    )
end
pages = Page.all

example_user = User.new(
  name:     'Example User',
  username: 'example',
  email:    'user@example.com', 
  password: 'password'
)
example_user.skip_confirmation!
example_user.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Page.count} pages created"