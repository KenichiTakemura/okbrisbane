require 'test_helper'

class TopFeedListsControllerTest < ActionController::TestCase
  setup do
    @top_feed_list = top_feed_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:top_feed_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create top_feed_list" do
    assert_difference('TopFeedList.count') do
      post :create, top_feed_list: {  }
    end

    assert_redirected_to top_feed_list_path(assigns(:top_feed_list))
  end

  test "should show top_feed_list" do
    get :show, id: @top_feed_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @top_feed_list
    assert_response :success
  end

  test "should update top_feed_list" do
    put :update, id: @top_feed_list, top_feed_list: {  }
    assert_redirected_to top_feed_list_path(assigns(:top_feed_list))
  end

  test "should destroy top_feed_list" do
    assert_difference('TopFeedList.count', -1) do
      delete :destroy, id: @top_feed_list
    end

    assert_redirected_to top_feed_lists_path
  end
end
