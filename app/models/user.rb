class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :date_of_birth, :ssn

  validates_length_of :ssn, maximum: 4
  validates_numericality_of :ssn, only_integer: true

  has_one :address
  accepts_nested_attributes_for :address

  def verify
    data = build_verification_data(self)
    user = BlockScore::Client.new(ENV['BLOCKSCORE_API_KEY'], version = 3)

    blockscore_verification = user.verification.create(data)

    self.verification_id = blockscore_verification["id"]

    if blockscore_verification["status"] == 'valid'
      self.verified = true
    else
      self.verified = false
    end
  end

  def build_verification_data(user)
    address = user.address

    data = {
      date_of_birth: user.date_of_birth,
      identification: { ssn: user.ssn },
      name: { first: user.first_name, middle: user.middle_name,
              last: user.last_name },
      address: { street1: address.street1, street2: address.street2,
                city: address.city, state: address.state,
                postal_code: address.postal_code,
                country_code: address.country_code }
    }
  end
end
