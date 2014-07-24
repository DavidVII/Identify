require 'rails_helper'

feature 'Allows users to signup' do
  scenario 'Viewing the signup page' do
    visit root_url

    expect(page).to have_content('Signup')
    expect(page).to have_content('Signin')
  end
end
