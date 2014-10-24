FactoryGirl.define do
  factory :user do
    sequence(:name, 100) { |n| "superman #{n}" }
    sequence(:username, 100) { |n| "username#{n}" }
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end
