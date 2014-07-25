def sign_in(user)
  visit new_user_session_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def sign_up_user
  within('form#new_user') do
    fill_in 'First name', with: 'Bruce'
    fill_in 'Middle name', with: 'Thomas'
    fill_in 'Last name', with: 'Wayne'
    fill_in 'Date of birth', with: '2-19-1939'
    fill_in 'Email', with: 'bruce@example.com'
    fill_in 'Password', with: 'thebat4eva'
    fill_in 'Password confirmation', with: 'thebat4eva'
    fill_in 'Last 4 of SSN', with: '1234'
    click_button 'Sign up'
  end
end
