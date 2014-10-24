FactoryGirl.define do
  factory :wiki do
    title "MyTitle"
    description "MyText"
    private false
    user
  end
end
