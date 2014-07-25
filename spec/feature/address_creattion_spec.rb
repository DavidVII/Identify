require 'rails_helper'

feature 'User adds their address' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
    visit new_address_path
  end

  scenario 'User sees the address form' do
    expect(page).to have_selector('form.verification')
  end

  describe 'The address is successfully added' do
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
  end
end
