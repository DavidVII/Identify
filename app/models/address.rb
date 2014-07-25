class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :street1, :city, :state, :postal_code, :country_code
end
