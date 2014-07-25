class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :date_of_birth

  has_one :address
  accepts_nested_attributes_for :address

  attr_reader :ssn

  def verify(user, address, identification_number)
    data = build_verification_data(user, address, identification_number)
    user = BlockScore::Client.new(ENV['BLOCKSCORE_API_KEY'], version = 3)

    blockscore_verification = user.verification.create(data)

    self.verification_id = blockscore_verification["id"]

    if blockscore_verification["status"] == 'valid'
      self.verified = true
    else
      self.verified = false
    end
  end

  def build_verification_data(user, address, identification_number)
    user_details = {
      date_of_birth: user.date_of_birth,
      identification: { ssn: identification_number },
      name: { first: user.first_name, middle: user.middle_name,
              last: user.last_name }
    }

    user_details.merge(address) { |key, old, new| old + new }
  end
end
