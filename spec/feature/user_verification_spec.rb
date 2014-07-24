require 'rails_helper'

feature 'The user can verify their identity' do
  let(:user) { FactoryGirl.create(:user) }

  before { sign_in(user) }

  scenario 'User sees the verification form' do
    visit '/unverified'

    expect(page).to have_selector('.verification-form')
  end

end
