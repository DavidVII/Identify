require 'rails_helper'

feature 'The user can verify their identity' do
  let(:user) { FactoryGirl.create(:user) }

  before { sign_in(user) }

  scenario 'User sees the verification form' do
    visit '/unverified'

    expect(page).to have_selector('form.verification')
  end

  describe 'User tries to be verified' do
    before do
      visit '/unverified'
      fill_in 'Street', with: '1313 Mockingbird Lane'
      fill_in 'Street continued', with: 'A'
      fill_in 'City', with: 'Los Angeles'
      fill_in 'State', with: 'CA'
      fill_in 'ZIP', with: '90210'
      fill_in 'Country', with: 'US'
    end

    scenario 'User is verified' do
      fill_in 'SSN', with: '0000'
      click_button 'Verify my identity'

      within('.app-checklist .verification') do
        expect(page).to have_selector('.fa-check')
      end

      expect(page.current_url).to include('/questionnaire')
    end

    scenario 'User is not verified' do
      fill_in 'SSN', with: '0001'
      click_button 'Verify my identity'

      within('.app-checklist .verification') do
        expect(page).to have_selector('.fa-times')
      end
    end
  end
end
