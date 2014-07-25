require 'rails_helper'

feature 'User manages their address' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
    visit new_address_path
  end

  scenario 'User sees the address form' do
    expect(page).to have_selector('form.verification')
  end

  describe 'The user adds their address' do
    before do
      fill_in 'Street', with: '1313 Mockingbird Lane'
      fill_in 'Street continued', with: 'A'
      fill_in 'City', with: 'Los Angeles'
      fill_in 'State', with: 'CA'
      fill_in 'ZIP', with: '90210'
    end

    scenario 'User sends valid data' do
      expect{ click_button 'Verify my identity' }.to change(Address, :count)
    end

    scenario 'Editing the address' do
      click_button 'Verify my identity'
      visit edit_address_path(user.address)
      fill_in 'State', with: 'NY'

      expect(find_field('State').value).to eq('NY')
    end
  end
end
