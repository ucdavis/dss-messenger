require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "Should not save message with no subject" do
    m = Message.new
    m.impact_statement = "Some Impact Statement"
    refute m.save, " |||||ERROR||||| Saved the message without subject"
  end
  test "Should not save message with no Impact Statement" do
    m = Message.new
    m.subject = "Some Subject"
    refute m.save, " |||||ERROR||||| Saved the message without Impact Statement"
  end
  # test "Should save message with a Subject & Impact Statement" do
  #   m = Message.new
  #   m.subject = "Some Subject"
  #   m.impact_statement = "Some Impact Statement"
  #   assert m.save, " |||||ERROR||||| Could not save the message with a Subject & Impact Statement"
  # end
  # test "Should find or create group recipient" do
  #   message = Message.first
  #   assert message.recipient_uids="57", " |||||ERROR||||| Could not find or create group recipient"
  # end
  # test "Should find or create individual recipient" do
  #   message = Message.first
  #   assert message.recipient_uids="13907", " |||||ERROR||||| Could not find or create individual recipient"
  # end
end
