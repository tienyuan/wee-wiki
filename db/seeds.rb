require 'faker'

# Create Example User
example_user = User.new(
  name:     'Example User',
  username: 'example',
  email:    'user@example.com', 
  password: 'password'
)
example_user.skip_confirmation!
example_user.save!

collab_user = User.new(
  name:     'Collaborator',
  username: 'collab',
  email:    'collab@example.com', 
  password: 'password'
)
collab_user.skip_confirmation!
collab_user.save!

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

# Create Public Wikis
8.times do
  Wiki.create!(
    title:       Faker::Lorem.sentence(2),
    description: Faker::Lorem.sentence(5),
    owner: users.sample
    )
end

# Create Private Wikis
4.times do
  Wiki.create!(
    title:       Faker::Lorem.sentence(2),
    description: Faker::Lorem.sentence(5),
    owner: example_user,
    private: true
    )
end
wikis = Wiki.all

# Create Pages
24.times do 
  page = Page.create!(
    wiki:  wikis.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
    )
end
pages = Page.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Page.count} pages created"