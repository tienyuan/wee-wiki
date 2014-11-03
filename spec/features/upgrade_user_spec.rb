require 'rails_helper'

feature "User attempts to upgrade", js: true do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  # This test has been commented out to prevent accidental abuse during development.
  # Uncomment the scenario when you wish to run the test against stripe's test server
  xscenario "when signed in" do
    visit new_charge_path
    click_button 'Pay with Card'
    sleep(8)
    within_frame('stripe_checkout_app') do
      fill_in 'card_number', with: "4242 4242 4242 4242"
      fill_in 'cc-exp', with: "12/20"
      fill_in 'cc-csc', with: "123"
      within 'form' do
        click_button 'Pay $10.00'
      end
    end
  end

  after do
    Warden.test_reset!
  end
end