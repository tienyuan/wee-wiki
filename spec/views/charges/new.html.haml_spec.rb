require "rails_helper"

describe 'charges/new', :type => :view do

  context 'current_user' do
    it 'can see upgrade button' do
      user = assign(:user, build_stubbed(:user, premium: false))
      assign(:stripe_btn_data, {})
      allow(view).to receive_messages(current_user: user)

      render

      expect(rendered).to have_content 'We accept all major credit cards.'
    end
  end

  context 'premium user' do
    it 'can see thank you' do
      user = assign(:user, build_stubbed(:user, premium: true))
      allow(view).to receive_messages(current_user: user)
      render

      expect(rendered).to have_content "Thanks! You're upgraded."
    end
  end

  context 'visitor' do
    it "can see sign up message" do
      allow(view).to receive_messages(current_user: nil)
      render

      expect(rendered).to have_content 'Start by Signing up for an Account'
    end
  end
end