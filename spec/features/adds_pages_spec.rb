require 'rails_helper'

feature "User creates a page", :type => :feature do

  include Warden::Test::Helpers

  before do
    setAuth
    @user = create(:user)
    login_as(@user, :scope => :user)
    wiki = create(:wiki, title: 'Wiki title', description: 'Wiki description')
  end

  scenario "with valid title and body" do
    visit wikis_path
    click_link "Wiki title"
    click_link "Add Page"
    fill_in 'page-title', with: "Page title"
    fill_in 'page-body', with: "Page body"

    within 'form' do
      click_button 'Submit'
    end
      
    expect(page).to have_content('Page added!')
    expect(page).to have_content('Page title')
    expect(page).to have_content('Page body')
  end

  scenario "with no title" do
    visit wikis_path
    click_link "Wiki title"
    click_link "Add Page"
    fill_in 'page-title', with: ""
    fill_in 'page-body', with: "Page body"

    within 'form' do
      click_button 'Submit'
    end
      
    expect(page).to have_content("Page failed.")
  end

  scenario "with no body" do
    visit wikis_path
    click_link "Wiki title"
    click_link "Add Page"
    fill_in 'page-title', with: "Page title"
    fill_in 'page-body', with: ""

    within 'form' do
      click_button 'Submit'
    end
      
    expect(page).to have_content("Page failed.")
  end

  after do
    clearAuth
  end

end