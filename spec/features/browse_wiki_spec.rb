require 'rails_helper'

feature 'User goes to wiki list', type: :feature do

  before do
    set_auth
    @user = create(:user)
    @collaborator = create(:user)
    @other = create(:user)
    public_wiki = create(:wiki, title: 'public wiki title', description: 'public wiki description')
    create(:wiki, title: 'owned wiki title', owner: @user, private: true)
    private_wiki = create(:wiki, title: 'private wiki title', private: true)
    create(:collaboration, wiki_id: private_wiki.id, user_id: @collaborator.id)
    create(:page, title: 'page title', body: 'page body', wiki: public_wiki)
  end

  scenario 'as an owner, sees public and owned wikis' do
    login_as(@user, scope: :user)

    visit root_path
    click_link 'Browse Wikis'

    expect(page).to have_content('public wiki title')
    expect(page).to have_content('public wiki description')
    expect(page).to have_content('owned wiki title')
    expect(page).not_to have_content('private wiki title')

    click_link 'owned wiki title'
    expect(page).to have_content('Edit Wiki')
    expect(page).to have_content('Add Page')
    expect(page).to have_button('Add User')
  end

  scenario 'as a collaborator, sees public and collaboration wikis' do
    login_as(@collaborator, scope: :user)

    visit root_path
    click_link 'Browse Wikis'

    expect(page).to have_content('public wiki title')
    expect(page).to have_content('public wiki description')
    expect(page).not_to have_content('owned wiki title')
    expect(page).to have_content('private wiki title')

    click_link 'private wiki title'
    expect(page).not_to have_content('Edit Wiki')
    expect(page).to have_content('Add Page')
    expect(page).not_to have_button('Add User')
  end

  scenario 'as a user, sees public wikis' do
    login_as(@other, scope: :user)

    visit root_path
    click_link 'Browse Wikis'

    expect(page).to have_content('public wiki title')
    expect(page).to have_content('public wiki description')
    expect(page).not_to have_content('owned wiki title')
    expect(page).not_to have_content('private wiki title')

    click_link 'public wiki title'
    expect(page).to have_content('page title')
    expect(page).to have_content('Edit Wiki')
    expect(page).to have_content('Add Page')
    expect(page).not_to have_button('Add User')

    click_link 'page title'
    expect(page).to have_content('page body')
    expect(page).to have_content('Edit Page')
    expect(page).to have_content('Delete Page')
  end

  scenario 'as a visitor, sees public wikis' do

    visit root_path
    click_link 'Browse Wikis'

    expect(page).to have_content('public wiki title')
    expect(page).to have_content('public wiki description')
    expect(page).not_to have_content('owned wiki title')
    expect(page).not_to have_content('private wiki title')

    click_link 'public wiki title'
    expect(page).to have_content('page title')
    expect(page).not_to have_content('Edit Wiki')
    expect(page).not_to have_content('Add Page')
    expect(page).not_to have_button('Add User')

    click_link 'page title'
    expect(page).not_to have_content('Edit Page')
    expect(page).not_to have_content('Delete Page')
  end

  after do
    clear_auth
  end
end
