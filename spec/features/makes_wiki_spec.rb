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
    click_link "Create Wiki"
    fill_in 'wiki-title', with: "wiki title"
    fill_in 'wiki-description', with: "wiki description here"

    within 'form' do
      click_button 'Create'
    end
      
    expect( page ).to have_content('Wiki created!')
  end

  scenario "create a private wiki" do
    visit wikis_path
    click_link "Create Wiki"
    fill_in 'wiki-title', with: "private wiki title"
    fill_in 'wiki-description', with: "private wiki description here"
    uncheck('wiki-private')

    within 'form' do
      click_button 'Create'
    end
      
    expect( page ).to have_content('Wiki created!')
  end

  after do
    Warden.test_reset!
  end

end