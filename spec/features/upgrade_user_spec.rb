require 'rails_helper'

feature "User attempts to upgrade" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  xscenario "when signed in" do
    visit new_charge_path
    click_link "Pay With Card"
    fill_in 'card-number', with: "4242 4242 4242 4242"
    fill_in 'cc-exp', with: "12/20"
    fill_in 'cc-csc', with: "123"
    within 'form' do
      click_button 'Pay $10.00'
    end
      
    expect(page).to have_content('Browse Wikis')
    
    visit new_wiki_path
    expect(page).to have_content('Private Wiki')
  end

  after do
    Warden.test_reset!
  end

end