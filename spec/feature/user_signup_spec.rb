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

  scenario 'User signs up' do
    visit root_url
    click_link 'Sign up'
    within('form#new_user') do
      fill_in 'First Name', with: 'Bruce'
      fill_in 'Middle Name', with: 'Thomas'
      fill_in 'Last Name', with: 'Wayne'
      fill_in 'Date of Birth', with: '2-19-1939'
      fill_in 'Email', with: 'bruce@example.com'
      fill_in 'Password', with: 'thebat4eva'
      fill_in 'Password Confirmation', with: 'thebat4eva'
      click_button 'Sign up'
    end
  end
end
