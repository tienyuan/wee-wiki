require 'rails_helper'

feature 'User goes to wiki list to', type: :feature do

  before do
    set_auth
    @user = create(:user)
    @wiki = create(:wiki, title: 'Wiki title', description: 'Wiki description')
    login_as(@user, scope: :user)
  end

  scenario 'edit a wiki' do
    visit wikis_path
    click_link 'Wiki title'
    click_link 'Edit Wiki'
    fill_in 'wiki-title', with: 'New wiki title'
    within 'form' do
      click_button 'Submit'
    end

    expect(page).to have_content('Wiki edited!')
    expect(page).to have_content('New wiki title')
    expect(page).to have_content('Wiki description')
  end

  after do
    clear_auth
  end
end
