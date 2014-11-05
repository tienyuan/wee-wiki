require "rails_helper"

describe 'welcome/index', :type => :view do

  context 'current_user' do
    it 'can see wiki link' do
      user = assign(:user, build_stubbed(:user))
      allow(view).to receive_messages(current_user: user)
      render

      expect(rendered).to have_content 'Create a Wiki'
    end
  end

  context 'visitor' do
    it "can see sign up link" do
      allow(view).to receive_messages(current_user: nil)
      render

      expect(rendered).to have_content 'Sign Up for an Account'
    end
  end
end