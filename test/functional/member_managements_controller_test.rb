require 'test_helper'

class MemberManagementsControllerTest < ActionController::TestCase
  setup do
    @member_management = member_managements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_managements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_management" do
    assert_difference('MemberManagement.count') do
      post :create, member_management: {  }
    end

    assert_redirected_to member_management_path(assigns(:member_management))
  end

  test "should show member_management" do
    get :show, id: @member_management
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member_management
    assert_response :success
  end

  test "should update member_management" do
    put :update, id: @member_management, member_management: {  }
    assert_redirected_to member_management_path(assigns(:member_management))
  end

  test "should destroy member_management" do
    assert_difference('MemberManagement.count', -1) do
      delete :destroy, id: @member_management
    end

    assert_redirected_to member_managements_path
  end
end
