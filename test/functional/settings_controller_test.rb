require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  setup do
    @setting = settings(:footer)
  end

  test "should update setting" do
    put :update, id: @setting, setting: { item_name: @setting.item_name, item_value: @setting.item_value }
    assert_redirected_to setting_path(assigns(:setting))
  end
end
