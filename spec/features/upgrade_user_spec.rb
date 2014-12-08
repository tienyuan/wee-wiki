require 'rails_helper'

feature 'User attempts to upgrade', js: true, type: :feature  do

  before do
    set_auth
    @user = create(:user)
    login_as(@user, scope: :user)
  end

  scenario 'when signed in', stripe_integration: true do
    visit new_charge_path
    click_button 'Pay with Card'
    sleep(8)
    within_frame('stripe_checkout_app') do
      fill_in 'card_number', with: '4242 4242 4242 4242'
      fill_in 'cc-exp', with: '12/20'
      fill_in 'cc-csc', with: '123'
      within 'form' do
        click_button 'Pay $10.00'
      end
    end
  end

  after do
    clear_auth
  end
end
