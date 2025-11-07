require 'test_helper'

class ModifiersControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("okadri")
    @modifier = modifiers(:update)
  end

  # test "should create modifier" do
  #   assert_difference('Modifier.count') do
  #     post :create, modifier: { description: @modifier.description }
  #   end
  #
  #   assert_redirected_to modifier_path(assigns(:modifier))
  # end
  #
  # test "should update modifier" do
  #   put :update, id: @modifier, modifier: { description: @modifier.description }
  #   assert_redirected_to modifier_path(assigns(:modifier))
  # end
  #
  # test "should destroy modifier" do
  #   assert_difference('Modifier.count', -1) do
  #     delete :destroy, id: @modifier
  #   end
  #
  #   assert_redirected_to modifiers_path
  # end
end
