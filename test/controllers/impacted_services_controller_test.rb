require 'test_helper'

class ImpactedServicesControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("okadri")
    @impacted_service = impacted_services(:file)
    @controller = Preferences::ImpactedServicesController.new
  end

  # test "should create impacted_service" do
  #   assert_difference('ImpactedService.count') do
  #     post :create, impacted_service: { name: @impacted_service.name }
  #   end
  #
  #   assert_redirected_to preferences_impacted_service_path(assigns(:impacted_service))
  # end
  #
  # test "should update impacted_service" do
  #   put :update, id: @impacted_service, impacted_service: { name: @impacted_service.name }
  #   assert_redirected_to impacted_service_path(assigns(:impacted_service))
  # end
  #
  # test "should destroy impacted_service" do
  #   assert_difference('ImpactedService.count', -1) do
  #     delete :destroy, id: @impacted_service
  #   end
  #
  #   assert_redirected_to impacted_services_path
  # end
end
