require 'rails_helper'

feature "User goes to wiki list to" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    @wiki = create(:wiki, title: 'Wiki title', description: 'Wiki description')
    @page = create(:page, wiki: @wiki, title: 'Page title', body: 'Page body')
    login_as(@user, :scope => :user)
  end

  scenario "edit a wiki" do
    visit wikis_path
    click_link "Wiki title"
    click_link "Page title"
    click_link "Edit Page"
    fill_in 'page-title', with: "New page title"

    within 'form' do
      click_button 'Edit'
    end
      
    expect(page).to have_content('Page edited!')
    expect(page).to have_content('New page title')
    expect(page).to have_content('Page body')
  end

  scenario "delete a wiki" do
    visit wikis_path
    click_link "Wiki title"
    click_link "Page title"
    click_link "Delete Page"
      
    expect(page).to have_content('Page deleted!')
  end

  after do
    Warden.test_reset!
  end

end