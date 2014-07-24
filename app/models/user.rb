class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :date_of_birth

  has_one :address

  attr_reader :ssn

  def verify
    true if self.first_name.present?
  end

  def verified?
    true if self.verify
  end
end
