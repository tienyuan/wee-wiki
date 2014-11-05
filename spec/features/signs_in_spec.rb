require 'rails_helper'

feature "Visitor signs in" do
  before do
    @user = create(:user)
  end

  scenario "with valid email and password" do
    signs_in_with(@user.email, @user.password)

    expect(current_path).to eq wikis_path 
    expect(page).to have_content('Browse Wikis')
  end

  scenario "with invalid email" do
    signs_in_with("blah@blah.com", @user.password)

    expect(current_path).to eq user_session_path
    expect(page).to have_content('Invalid email address or password.')
  end

  scenario "with blank password" do
    signs_in_with(@user.email, "")

    expect(current_path).to eq user_session_path
    expect(page).to have_content('Invalid email address or password.')
  end
  
  scenario "doesn't sign in" do
    visit wikis_path

    expect(current_path).to eq wikis_path
    expect(page).to have_content('Browse Wikis')
  end

  private

  def signs_in_with(email, password)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    within 'form' do
      click_button 'Sign in'
    end
  end
end