require 'rails_helper'

feature "User edits account" do

  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before do
    reset_mailer
    @user = create(:user)
    signs_in_with(@user.email, @user.password)
    click_link @user.username
  end

  scenario "with a new email, password, name, new username and valid current password" do
    expect(current_path).to eq edit_user_registration_path 
    expect(page).to have_content('Edit User')
    
    fill_in 'Email', with: 'lex@luthorcorp.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Name', with: 'Lex Luthor'
    fill_in 'Username', with: 'lex'
    fill_in 'user_current_password', with: @user.password
    click_button 'Update'

    expect(page).to have_content('You updated your account successfully, but we need to verify your new email address. Please check your email and follow the confirm link to confirm your new email address.')
    click_email_confirmation_link('lex@luthorcorp.com')

    expect(page).to have_content('Your email address has been successfully confirmed.')
    expect(User.last.email).to eq('lex@luthorcorp.com')
    expect(User.last.name).to eq('Lex Luthor')
    expect(User.last.username).to eq('lex')
  end

  scenario "with a new password, name, new username and invalid current password" do
    expect(current_path).to eq edit_user_registration_path 
    expect(page).to have_content('Edit User')
    
    fill_in 'Email', with: 'lex@luthorcorp.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Name', with: 'Lex Luthor'
    fill_in 'Username', with: 'lex'
    fill_in 'user_current_password', with: 'invalidpass'
    click_button 'Update'

    expect(page).to have_content('Current password is invalid')
  end

  scenario "and cancels account" do
    expect(current_path).to eq edit_user_registration_path 
    expect(page).to have_content('Edit User')
    click_button 'Cancel account'

    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
    expect(User.count).to eq 0
  end

  private

  def click_email_confirmation_link(email)
    open_email(email, with_subject: "Confirmation instructions")
    visit_in_email("Confirm my account")
  end

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