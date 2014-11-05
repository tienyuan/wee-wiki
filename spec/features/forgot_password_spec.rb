require 'rails_helper'

feature "User resets password" do

  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before do
    reset_mailer
    @user = create(:user)
  end

  scenario "with valid email" do
    reset_password(@user.email)
    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')

    click_forgot_password_link(@user.email, 'password')
    expect(current_path).to eq wikis_path 
    expect(page).to have_content('Browse Wikis')
    expect(page).to have_content('Your password has been changed successfully. You are now signed in.')
  end

  scenario "with invalid email" do
    reset_password("blah@blah.com")

    expect(current_path).to eq user_password_path
    expect(page).to have_content('Email not found')
  end

  private

  def reset_password(email)
    visit root_path
    click_link 'Sign In'
    click_link 'Forgot your password?'
    fill_in 'Email', with: email
    within 'form' do
      click_button 'Send me reset password instructions'
    end 
  end

  def click_forgot_password_link(email, password)
    open_email(email, with_subject: "Reset password instructions")
    visit_in_email("Change my password")
    fill_in 'New password', with: password
    fill_in 'Confirm new password', with: password
    within 'form' do
      click_button 'Change my password'
    end    
  end
end