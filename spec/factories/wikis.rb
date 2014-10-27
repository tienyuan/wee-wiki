FactoryGirl.define do
  factory :wiki do
    title "MyTitle"
    description "MyText"
    private false
    owner { create(:user) }
  end
end
