class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :email_confirmation, :website, :message

  validates_presence_of :name, :email, :email_confirmation, :message
  validates_format_of :email, :with => /^[^@]+@[^\.]+\..+$/
  validates_confirmation_of :email

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
