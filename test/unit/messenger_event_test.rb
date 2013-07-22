require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "Should not save messenger event with no description" do
    messenger_event = MessengerEvent.new
    refute messenger_event.save, " |||||ERROR||||| Saved the messenger event without description"
  end

  test "Should save messenger event with valid description" do
    messenger_event = MessengerEvent.new
    messenger_event.description = "Test Messenger Event"
    assert messenger_event.save, " |||||ERROR||||| Could not save messenger event with valid description"
  end
end
