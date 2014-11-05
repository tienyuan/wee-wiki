require 'rails_helper'

feature "User edits account" do
  scenario "and cancels account" do
    user = create(:user)
    signs_in_with(user.email, user.password)
    click_link user.username
    expect(current_path).to eq edit_user_registration_path 
    expect(page).to have_content('Edit User')
    click_button 'Cancel account'

    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
    expect(User.count).to eq 0
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