require 'test_helper'

class RecipientTest < ActiveSupport::TestCase
  test "Should not save recipient with no uid" do
    recipient = Recipient.new
    refute recipient.save, " |||||ERROR||||| Saved the classifcation without uid"
  end

  test "Should save recipient with valid uid" do
    recipient = Recipient.new
    recipient.uid = "Test Recipient"
    assert recipient.save, " |||||ERROR||||| Could not save recipient with valid uid"
  end
end
