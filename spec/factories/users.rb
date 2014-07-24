# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Bruce"
    middle_name "Thomas"
    last_name "Wayne"
    date_of_birth "12-19-1984"
    email "bruce@example.com"
    password "thebat4eva"
    confirmed_at 1.day.ago
  end
end
