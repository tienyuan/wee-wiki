require 'rails_helper'

feature "User goes to wiki list" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    login_as(@user, :scope => :user)
  end

  scenario "sees wiki title" do
    wiki = create(:wiki, title: 'wiki title', description: 'wiki description')
    visit wikis_path
    expect( page ).to have_content('wiki title')
    expect( page ).to have_content('wiki description')
  end

  after do
    Warden.test_reset!
  end

end