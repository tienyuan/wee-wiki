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

  xscenario "with a valid user" do
    visit wikis_path
    
    click_link "wiki title"

    fill_in 'user-email', with: "@collaborator.email"
    within 'form' do
      click_button 'Add'
    end

    expect(page).to have_content('Collaborator added!')
  end

  xscenario "with an invalid user" do
    visit wikis_path
    click_link "wiki title"
    click_link "Add Collaborators"
  end

  after do
    Warden.test_reset!
  end

end