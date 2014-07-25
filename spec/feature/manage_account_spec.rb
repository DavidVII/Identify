require 'rails_helper'

feature 'User manages their account' do
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
    sign_up_user

    open_email 'bruce@example.com'
    visit_in_email 'Confirm my account'

    fill_in 'Email', with: 'bruce@example.com'
    fill_in 'Password', with: 'thebat4eva'
    click_button 'Sign in'

    current_user = User.last
    current_user_name = "#{current_user.first_name} #{current_user.last_name}"

    expect(page).to have_content(current_user_name)
    expect(page.current_url).to include(new_address_path)
  end

  describe 'User edits their account' do
    before do
      user = FactoryGirl.create(:user)
      sign_in(user)
      visit edit_user_registration_path
    end

    scenario 'User updates account' do
      fill_in 'First name', with: 'Alfred'
      fill_in 'Middle name', with: ''
      fill_in 'Last name', with: 'Pennyworth'
      fill_in 'Last 4 of SSN', with: '1234'
      fill_in 'Current password', with: 'thebat4eva'
      click_button 'Update account'

      expect(page).to have_content('Alfred Pennyworth')
    end
  end
end
