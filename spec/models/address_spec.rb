require 'rails_helper'

RSpec.describe Address, :type => :model do
  describe 'Validations' do
    it { should validate_presence_of :street1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :postal_code }
    it { should validate_presence_of :country_code }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
