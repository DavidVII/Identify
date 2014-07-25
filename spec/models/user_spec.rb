require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'Validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :date_of_birth }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :ssn }

    it { should_not allow_value('abc1').for(:ssn) }
    it { should_not allow_value('abc123').for(:ssn) }

    it { should allow_value('1234').for(:ssn) }
  end

  describe 'Associations' do
    it { should have_one(:address) }
  end
end
