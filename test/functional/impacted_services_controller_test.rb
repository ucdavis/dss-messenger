require 'test_helper'

class ImpactedServicesControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("okadri")
    @impacted_service = impacted_services(:file)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:impacted_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create impacted_service" do
    assert_difference('ImpactedService.count') do
      post :create, impacted_service: { name: @impacted_service.name }
    end

    assert_redirected_to impacted_service_path(assigns(:impacted_service))
  end

  test "should show impacted_service" do
    get :show, id: @impacted_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @impacted_service
    assert_response :success
  end

  test "should update impacted_service" do
    put :update, id: @impacted_service, impacted_service: { name: @impacted_service.name }
    assert_redirected_to impacted_service_path(assigns(:impacted_service))
  end

  test "should destroy impacted_service" do
    assert_difference('ImpactedService.count', -1) do
      delete :destroy, id: @impacted_service
    end

    assert_redirected_to impacted_services_path
  end
end
