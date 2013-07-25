require 'test_helper'

class MessengerEventsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("okadri")
    @messenger_event = messenger_events(:sendemail)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messenger_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('MessengerEvent.count') do
      post :create, messenger_event: { description: @messenger_event.description }
    end

    assert_redirected_to messenger_event_path(assigns(:messenger_event))
  end

  test "should show event" do
    get :show, id: @messenger_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messenger_event
    assert_response :success
  end

  test "should update event" do
    put :update, id: @messenger_event, messenger_event: { description: @messenger_event.description }
    assert_redirected_to messenger_event_path(assigns(:messenger_event))
  end

  test "should destroy event" do
    assert_difference('MessengerEvent.count', -1) do
      delete :destroy, id: @messenger_event
    end

    assert_redirected_to messenger_events_path
  end
end
