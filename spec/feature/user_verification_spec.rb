require 'rails_helper'

feature 'The user can verify their identity' do
  scenario 'User is verified' do
    valid_user = FactoryGirl.create(:user, ssn: '0000')
    sign_in(valid_user)
    visit new_address_path

    fill_in 'Street', with: '1313 Mockingbird Lane'
    fill_in 'Street continued', with: 'A'
    fill_in 'City', with: 'Los Angeles'
    fill_in 'State', with: 'CA'
    fill_in 'ZIP', with: '90210'
    click_button 'Verify my identity'

    within('.app-checklist .verification') do
      expect(page).to have_selector('.fa-check')
    end
  end

  scenario 'User is not verified' do
    invalid_user = FactoryGirl.create(:user, ssn: '0001')
    sign_in(invalid_user)
    visit new_address_path
    user = user

    fill_in 'Street', with: '1313 Mockingbird Lane'
    fill_in 'Street continued', with: 'A'
    fill_in 'City', with: 'Los Angeles'
    fill_in 'State', with: 'CA'
    fill_in 'ZIP', with: '90210'
    click_button 'Verify my identity'

    within('.app-checklist .verification') do
      expect(page).to have_selector('.fa-times')
    end
  end
end
