require 'rails_helper'

feature "User adds collaborators" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    @collaborator = create(:user)
    login_as(@user, :scope => :user)
    @public_wiki = create(:wiki, title: 'public wiki title')
    @private_wiki = create(:wiki, title: 'private wiki title', description: 'wiki description', private: true, owner: @user)
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
    Warden.test_reset!
  end

end