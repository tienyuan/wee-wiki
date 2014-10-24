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
    fill_in 'wiki-title', with: "Wiki title"
    fill_in 'wiki-description', with: "Wiki description"

    within 'form' do
      click_button 'Create'
    end
      
    expect(page).to have_content('Wiki created!')
    expect(page).to have_content('Wiki title')
    expect(page).to have_content('Wiki description')
    expect(page).to have_content(@user.username)
  end

  scenario "create a private wiki" do
    visit wikis_path
    click_link "Create Wiki"
    fill_in 'wiki-title', with: "Private wiki title"
    fill_in 'wiki-description', with: "Private wiki description"
    check('wiki-private')

    within 'form' do
      click_button 'Create'
    end
      
    expect(page).to have_content('Wiki created!')
    expect(page).to have_content('Private wiki title')
    expect(page).to have_content('Private wiki description')
    expect(page).to have_content(@user.username)
  end

  after do
    Warden.test_reset!
  end

end