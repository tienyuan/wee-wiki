require 'rails_helper'

feature "User adds collaborators to wiki" do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    @collaborator = create(:user)
    login_as(@user, :scope => :user)
    @wiki = create(:wiki, title: 'wiki title', description: 'wiki description')
  end

  scenario "with a valid user email" do
    visit wikis_path
    click_link "wiki title"

    fill_in 'user-email', with: @collaborator.email
    within 'form' do
      click_button 'Add'
    end

    expect(page).to have_content('Collaborator added!')
    expect(page).to have_content(@collaborator.username)
  end

  scenario "with an invalid user email" do
    visit wikis_path
    click_link "wiki title"

    fill_in 'user-email', with: 'invalid@email.com'
    within 'form' do
      click_button 'Add'
    end

    expect(page).to have_content('Collaborator failed.')
  end

   scenario "with a blank email" do
    visit wikis_path
    click_link "wiki title"

    fill_in 'user-email', with: ''
    within 'form' do
      click_button 'Add'
    end

    expect(page).to have_content('Collaborator failed.')
  end

  after do
    Warden.test_reset!
  end

end