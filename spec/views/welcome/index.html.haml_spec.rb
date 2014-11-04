require "rails_helper"

describe 'welcome/index.html.haml' do

  include Devise::TestHelpers

  context 'current_user' do
    it 'can see wiki link' do
      assign(:current_user, User.new)
      sign_in

      render

      expect(rendered).to have_content 'Create a Wiki'
    end
  end

  context 'visitor' do
    it "can see sign up link" do
      assign(:current_user, User.new)

      render

      expect(rendered).to have_content 'Sign Up for an Account'
    end
  end
end