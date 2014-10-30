require 'rails_helper'

feature "User goes to wiki list" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    public_wiki = create(:wiki, title: 'public wiki title', description: 'public wiki description')
    owned_wiki = create(:wiki, title: 'owned wiki title', owner: @user)
    private_wiki = create(:wiki, title: 'private wiki title', private: true)
    page = create(:page, title: 'page title', body: 'page body', wiki: public_wiki)
    login_as(@user, :scope => :user)
  end

  scenario "sees public and owned wikis" do
    
    visit root_path
    click_link "Browse Wikis"

    expect(page).to have_content('public wiki title')
    expect(page).to have_content('public wiki description')
    expect(page).to have_content('owned wiki title')
    expect(page).not_to have_content('private wiki title')

    click_link "public wiki title"
    expect(page).to have_content('page title')

    click_link "page title"
    expect(page).to have_content('page body')
  end

  after do
    Warden.test_reset!
  end

end