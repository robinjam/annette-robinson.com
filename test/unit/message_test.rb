require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  setup do
    @model = Message.new
    @valid_attributes = {
      name: 'John Doe',
      email: 'me@example.com',
      email_confirmation: 'me@example.com',
      website: '',
      message: 'This is my message.'
    }
  end

  test "should not be valid" do
    assert !Message.new.valid?
  end

  test "should validate with valid attributes" do
    assert Message.new(@valid_attributes).valid?
  end

  test "should not validate if required attributes are missing" do
    assert !Message.new(@valid_attributes.except :name).valid?
    assert !Message.new(@valid_attributes.except :email).valid?
    assert !Message.new(@valid_attributes.except :message).valid?
    assert !Message.new(@valid_attributes.except :email_confirmation).valid?
  end

  test "should not validate with invalid email address" do
    assert !Message.new(@valid_attributes.merge(email: 'blah', email_confirmation: 'blah')).valid?
  end

  test "should require confimation of email address" do
    assert !Message.new(@valid_attributes.merge(email_confirmation: 'blah')).valid?
  end
end
