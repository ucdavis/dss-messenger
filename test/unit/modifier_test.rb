require 'test_helper'

class ModifierTest < ActiveSupport::TestCase
  test "Should not save modifier with no description" do
    modifier = Modifier.new
    refute modifier.save, " |||||ERROR||||| Saved the modifier without description"
  end

  test "Should save classification with valid description" do
    modifier = Modifier.new
    modifier.description = "Test Modifier"
    assert modifier.save, " |||||ERROR||||| Could not save modifier with valid description"
  end
end
