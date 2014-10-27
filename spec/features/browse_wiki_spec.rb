require 'rails_helper'

feature "User goes to wiki list" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    wiki = create(:wiki, title: 'wiki title', description: 'wiki description')
    page = create(:page, title: 'page title', body: 'page body', wiki: wiki)
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  scenario "sees a wiki" do
    
    visit root_path
    click_link "See Wikis"

    expect(page).to have_content('wiki title')
    expect(page).to have_content('wiki description')

    click_link "wiki title"
    expect(page).to have_content('page title')

    click_link "page title"
    expect(page).to have_content('page body')
  end

  after do
    Warden.test_reset!
  end

end