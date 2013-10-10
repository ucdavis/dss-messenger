require 'test_helper'

class RecipientsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("okadri")
    @recipient = recipients(:one)
  end

  test "should create recipient" do
    assert_difference('Recipient.count') do
      post :create, recipient: { uid: @recipient.uid }
    end

    assert_redirected_to recipient_path(assigns(:recipient))
  end

  test "should update recipient" do
    put :update, id: @recipient, recipient: { uid: @recipient.uid }
    assert_redirected_to recipient_path(assigns(:recipient))
  end

  test "should destroy recipient" do
    assert_difference('Recipient.count', -1) do
      delete :destroy, id: @recipient
    end

    assert_redirected_to recipients_path
  end
end
