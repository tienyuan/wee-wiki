require 'rails_helper'

feature 'User goes to wiki list to', type: :feature do

  feature 'as a premium user' do
    before do
      set_auth
      @user = create(:user, premium: true)
      login_as(@user, scope: :user)
    end

    scenario 'create a wiki' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: 'Wiki title'
      fill_in 'wiki-description', with: 'Wiki description'
      within 'form' do
        click_button 'Submit'
      end

      expect(page).to have_content('Wiki created!')
      expect(page).to have_content('Wiki title')
      expect(page).to have_content('Wiki description')
    end

    scenario 'create a private wiki' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: 'Private wiki title'
      fill_in 'wiki-description', with: 'Private wiki description'
      check('wiki-private')
      within 'form' do
        click_button 'Submit'
      end

      expect(page).to have_content('Wiki created!')
      expect(page).to have_content('Private wiki title')
      expect(page).to have_content('Private wiki description')
      expect(Wiki.last.private).to eq true
    end

    scenario 'fails to create a wiki with no title' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: ''
      fill_in 'wiki-description', with: 'Wiki description'
      within 'form' do
        click_button 'Submit'
      end

      expect(page).to have_content('Wiki failed.')
    end

    scenario 'fails to create a wiki with no description' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: 'Wiki title'
      fill_in 'wiki-description', with: ''
      within 'form' do
        click_button 'Submit'
      end

      expect(page).to have_content('Wiki failed.')
    end

    after do
      clear_auth
    end
  end

  feature 'as a normal user' do
    before do
      set_auth
      @user = create(:user)
      login_as(@user, scope: :user)
    end

    scenario 'create a wiki' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: 'Wiki title'
      fill_in 'wiki-description', with: 'Wiki description'
      within 'form' do
        click_button 'Submit'
      end

      expect(page).to have_content('Wiki created!')
      expect(page).to have_content('Wiki title')
      expect(page).to have_content('Wiki description')
    end

    scenario 'create a private wiki' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: 'Private wiki title'
      fill_in 'wiki-description', with: 'Private wiki description'

      expect(page).not_to have_content('Private wiki')
    end

    scenario 'fails to create a wiki with no title' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: ''
      fill_in 'wiki-description', with: 'Wiki description'
      within 'form' do
        click_button 'Submit'
      end

      expect(page).to have_content('Wiki failed.')
    end

    scenario 'fails to create a wiki with no description' do
      visit wikis_path
      click_link 'Create Wiki'
      fill_in 'wiki-title', with: 'Wiki title'
      fill_in 'wiki-description', with: ''
      within 'form' do
        click_button 'Submit'
      end

      expect(page).to have_content('Wiki failed.')
    end

    after do
      clear_auth
    end
  end
end
