require 'rails_helper'

feature 'Allows users to signup' do
  scenario 'Viewing signup/signin options on homepage' do
    visit root_url

    expect(page).to have_link('Sign up', href: new_user_registration_path)
    expect(page).to have_link('Sign in', href: new_user_session_path)
  end

  scenario 'Viewing the signup form' do
    visit root_url
    click_link 'Sign up'

    expect(page).to have_selector('form#new_user')
  end

  scenario 'User signs up and confirms account' do
    visit root_url
    click_link 'Sign up'

    within('form#new_user') do
      fill_in 'First name', with: 'Bruce'
      fill_in 'Middle name', with: 'Thomas'
      fill_in 'Last name', with: 'Wayne'
      fill_in 'Date of birth', with: '2-19-1939'
      fill_in 'Email', with: 'bruce@example.com'
      fill_in 'Password', with: 'thebat4eva'
      fill_in 'Password confirmation', with: 'thebat4eva'
      click_button 'Sign up'
    end

    open_email 'bruce@example.com'
    visit_in_email 'Confirm my account'

    fill_in 'Email', with: 'bruce@example.com'
    fill_in 'Password', with: 'thebat4eva'
    click_button 'Sign in'

    current_user = User.last
    current_user_name = "#{current_user.first_name} #{current_user.last_name}"

    expect(page).to have_content(current_user_name)
  end
end
