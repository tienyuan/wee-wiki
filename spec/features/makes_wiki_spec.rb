require 'rails_helper'

feature "User goes to wiki list to" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  scenario "create a wiki" do
    visit wikis_path
    click_link "New Wiki"
    fill_in 'title', with: "wiki title"
    fill_in 'description', with: "wiki description here"

    within 'form' do
      click_button 'Submit'
    end
      
    expect( page ).to have_content('Wiki created!')
  end

  scenario "create a private wiki" do
    visit wikis_path
    click_link "New Wiki"
    fill_in 'title', with: "private wiki title"
    fill_in 'description', with: "private wiki description here"
    check_box "Private"

    within 'form' do
      click_button 'Submit'
    end
      
    expect( page ).to have_content('Wiki created!')
  end

  after do
    Warden.test_reset!
  end

end