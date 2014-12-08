FactoryGirl.define do
  factory :page do
    sequence(:title, 100) { |n| "MyPageTitle #{n}" }
    body 'MyPageBody'
    wiki
  end
end
