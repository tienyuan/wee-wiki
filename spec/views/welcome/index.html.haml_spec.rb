require "rails_helper"

describe 'welcome/index.html.haml' do

  include Devise::TestHelpers

  context 'current_user' do
    it 'can see wiki link' do
      @user = create(:user)
      sign_in @user

      render

      expect(rendered).to have_content 'Create a Wiki'
    end
  end

  context 'visitor' do
    it "can see sign up link" do

      render

      expect(rendered).to have_content 'Sign Up for an Account'
    end
  end
end