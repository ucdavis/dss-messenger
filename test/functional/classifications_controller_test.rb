require 'test_helper'

class ClassificationsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("okadri")
    @classification = classifications(:degradation)
  end

  test "should create classification" do
    assert_difference('Classification.count') do
      post :create, classification: { description: @classification.description }
    end

    assert_redirected_to classification_path(assigns(:classification))
  end

  test "should update classification" do
    put :update, id: @classification, classification: { description: @classification.description }
    assert_redirected_to classification_path(assigns(:classification))
  end

  test "should destroy classification" do
    assert_difference('Classification.count', -1) do
      delete :destroy, id: @classification
    end

    assert_redirected_to classifications_path
  end
end
