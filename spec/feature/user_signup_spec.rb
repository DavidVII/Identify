require 'rails_helper'

feature 'Allows users to signup' do
  scenario 'Viewing signup/signin options on homepage' do
    visit root_url

    expect(page).to have_link('Sign up', href: 'users/sign_up')
    expect(page).to have_link('Sign in', href: 'users/sign_in')
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

    expect(page).to have_content('Account: Bruce Wayne')
  end
end
