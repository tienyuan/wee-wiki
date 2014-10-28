FactoryGirl.define do
  factory :wiki do
    sequence(:title, 100) { |n| "MyWikiTitle #{n}" }
    description "MyText"
    private false
    owner { create(:user) }
  end
end
