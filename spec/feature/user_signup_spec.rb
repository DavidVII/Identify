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
end
