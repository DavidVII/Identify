class User < ActiveRecord::Base
  @@client = BlockScore::Client.new(ENV['BLOCKSCORE_API_KEY'], version = 3)

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :date_of_birth, :ssn

  validates_length_of :ssn, maximum: 4
  validates_numericality_of :ssn, only_integer: true

  has_one :address
  accepts_nested_attributes_for :address

  def verify
    blockscore_verification = @@client.verification.create(self.data_package)

    self.verification_id = blockscore_verification["id"]

    if blockscore_verification["status"] == 'valid'
      self.verified = true
    else
      self.verified = false
    end

    self.save
  end

  def data_package
    address = self.address

    data = {
      date_of_birth: self.date_of_birth,
      identification: { ssn: self.ssn },
      name: { first: self.first_name, middle: self.middle_name,
              last: self.last_name },
      address: { street1: address.street1, street2: address.street2,
                city: address.city, state: address.state,
                postal_code: address.postal_code,
                country_code: address.country_code }
    }
  end

  def retrieve_questions
    user_verification = @@client.verification.retrieve(self.verification_id)
    if user_verification["question_sets"].present?
      question_set = @@client.question_set.retrieve(
                                    user_verification["question_sets"].sample)

      question_set["questions"]
    else
      question_set = generate_questions
      question_set["questions"]
    end
  end

  def generate_questions
    @@client.question_set.create(self.verification_id)
  end
end
