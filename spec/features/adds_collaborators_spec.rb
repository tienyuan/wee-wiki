require 'rails_helper'

feature "User adds collaborators", :type => :feature do

  include Warden::Test::Helpers

  before do
    setAuth
    @user = create(:user)
    @collaborator = create(:user)
    @public_wiki = create(:wiki, title: 'public wiki title')
    @private_wiki = create(:wiki, title: 'private wiki title', description: 'wiki description', private: true, owner: @user)
    login_as(@user, :scope => :user)
  end

  scenario "to private wiki using a valid user email and then removes it" do
    visit wikis_path
    click_link "private wiki title"
    fill_in 'user-email', with: @collaborator.email
    within 'form' do
      click_button 'Add'
    end

    expect(page).to have_content('Collaborator added!')
    expect(page).to have_content(@collaborator.username)

    click_link "Remove"
    expect(page).to have_content('Collaborator removed.')
    expect(page).not_to have_content(@collaborator.username)
  end

  scenario "fails with an invalid user email" do
    visit wikis_path
    click_link "private wiki title"
    fill_in 'user-email', with: 'invalid@email.com'
    within 'form' do
      click_button 'Add'
    end

    expect(page).to have_content('Collaborator failed.')
  end

  scenario "fails with a blank email" do
    visit wikis_path
    click_link "private wiki title"
    fill_in 'user-email', with: ''
    within 'form' do
      click_button 'Add'
    end

    expect(page).to have_content('Collaborator failed.')
  end

  scenario "fails with a public wiki" do
    visit wikis_path
    click_link "public wiki title"

    expect(page).not_to have_content('user-email')
  end

  after do
    clearAuth
  end

end