require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should create message" do
  #   assert_difference('Message.count') do
  #     post :create, message: { impact_statement: @message.impact_statement, other_services: @message.other_services, purpose: @message.purpose, resolution: @message.resolution, sender_uid: @message.sender_uid, subject: @message.subject, window_end: @message.window_end, window_start: @message.window_start, workaround: @message.workaround }
  #   end
  # 
  #   assert_redirected_to message_path(assigns(:message))
  # end

  test "should show message" do
    get :show, id: @message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message
    assert_response :success
  end

  # test "should update message" do
  #   put :update, id: @message, message: { impact_statement: @message.impact_statement, other_services: @message.other_services, purpose: @message.purpose, resolution: @message.resolution, sender_uid: @message.sender_uid, subject: @message.subject, window_end: @message.window_end, window_start: @message.window_start, workaround: @message.workaround }
  #   assert_redirected_to message_path(assigns(:message))
  # end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end
end
