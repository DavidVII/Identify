class Questionnaire
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{value}=", name)
    end
  end

  def persisted?
    false
  end
end
