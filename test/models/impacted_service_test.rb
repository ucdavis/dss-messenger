require 'test_helper'

class ImpactedServiceTest < ActiveSupport::TestCase
  test "Should not save impacted service with no name" do
    impacted_service = ImpactedService.new
    refute impacted_service.save, " |||||ERROR||||| Saved the save impacted service without description"
  end

  test "Should save save impacted service with valid name" do
    impacted_service = ImpactedService.new
    impacted_service.name = "Test Impacted Service"
    assert impacted_service.save, " |||||ERROR||||| Could not save save impacted service with valid name"
  end
end
