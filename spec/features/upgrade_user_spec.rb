require 'rails_helper'

feature "User attempts to upgrade", js: true do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  xscenario "when signed in" do
    visit new_charge_path
    stripe = page.driver.window_handles.last
    click_button '<span style="display: block; min-height: 30px;">Pay with Card</span>'
    
    fill_in 'card-number', with: "4242 4242 4242 4242"
    fill_in 'cc-exp', with: "12/20"
    fill_in 'cc-csc', with: "123"
    within 'form' do
      click_button 'Pay $10.00'
    end
  end

  after do
    Warden.test_reset!
  end
end