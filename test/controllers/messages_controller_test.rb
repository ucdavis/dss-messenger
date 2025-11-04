require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    fake_cas_login
    @message = messages(:one)
    @recipient = recipients(:one)
    @publisher = publishers(:one)
  end

  test "unauthorized users redirected to CAS" do
    revoke_all_access
    get :index
    assert_response :unauthorized
  end

  # test "should get index and assign needed variables" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:messages)
  #   assert_not_nil assigns(:classifications)
  #   assert_not_nil assigns(:impacted_services)
  #   assert_not_nil assigns(:modifiers)
  #   assert_not_nil assigns(:settings)
  # end

  test "should get open messages" do
    get :open
    assert_response :success
    assert_not_nil assigns(:open_messages)
  end

  # test "should create message" do
  #   assert_difference('Message.count') do
  #     post :create, message: { subject: @message.subject, impact_statement: @message.impact_statement, recipient_uids: @recipient.uid, publisher_ids: [ @publisher.id ] }
  #   end
  #
  #   assert_redirected_to message_path(assigns(:message))
  # end
  #
  # test "should update message" do
  #   put :update, id: @message, message: { closed: true }
  #   assert_equal true, assigns(:message).closed
  # end
  #
  # test "should not create message in case of missing required fields" do
  #   assert_no_difference('Message.count') do
  #     post :create, message: { subject: @message.subject, impact_statement: @message.impact_statement, recipient_uids: @recipient.uid }
  #   end
  #   assert_no_difference('Message.count') do
  #     post :create, message: { impact_statement: @message.impact_statement, recipient_uids: @recipient.uid}
  #   end
  #   assert_no_difference('Message.count') do
  #     post :create, message: { subject: @message.subject, recipient_uids: @recipient.uid}
  #   end
  #   assert_no_difference('Message.count') do
  #     post :create, message: { subject: @message.subject, impact_statement: @message.impact_statement}
  #   end
  # end
  #
  # test "should destroy message" do
  #   assert_difference('Message.count', -1) do
  #     delete :destroy, id: @message
  #   end
  #
  #   assert_redirected_to messages_path
  # end
end
