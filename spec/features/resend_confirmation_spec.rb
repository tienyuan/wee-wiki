require 'rails_helper'

feature 'Visitor resends confirmation' do

  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before do
    reset_mailer
    set_auth
  end

  scenario 'with valid email' do
    sign_up_with('new_email@example.com', 'Clark Kent', 'new_username', 'password')
    resend_confirmation_email('new_email@example.com')

    expect(all_emails.count).to eq 2
    click_email_confirmation_link('new_email@example.com')

    expect(current_path).to eq user_confirmation_path
  end

  scenario 'with invalid email' do
    resend_confirmation_email('new_email@example')
    expect(page).to have_content('Email not found')
  end

  scenario 'with already confirmed email' do
    sign_up_with('new_email@example.com', 'Clark Kent', 'new_username', 'password')
    click_email_confirmation_link('new_email@example.com')

    resend_confirmation_email('new_email@example.com')
    expect(page).to have_content('Email was already confirmed, please try signing in')
  end

  after do
    clear_auth
  end

  private

  def resend_confirmation_email(email)
    visit root_path
    click_link 'Sign Up'
    click_link 'Didn\'t receive confirmation instructions?'
    fill_in 'Email', with: email
    within 'form' do
      click_button 'Resend confirmation instructions'
    end
  end

  def click_email_confirmation_link(email)
    open_email(email, with_subject: 'Confirmation instructions')
    visit_in_email('Confirm my account')
  end

  def sign_up_with(email, name, username, password)
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: email
    fill_in 'Name', with: name
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    within 'form' do
      click_button 'Sign up'
    end
  end
end
