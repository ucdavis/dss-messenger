require 'test_helper'

class ClassificationTest < ActiveSupport::TestCase
  test "Should not save classification with no description" do
    classification = Classification.new
    refute classification.save, " |||||ERROR||||| Saved the classifcation without description"
  end

  test "Should save classification with valid description" do
    classification = Classification.new
    classification.description = "Test Classification"
    assert classification.save, " |||||ERROR||||| Could not save classifcation with valid description"
  end
end
