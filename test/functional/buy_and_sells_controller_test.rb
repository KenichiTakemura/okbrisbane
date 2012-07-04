require 'test_helper'

class BuyAndSellsControllerTest < ActionController::TestCase
  setup do
    @buy_and_sell = buy_and_sells(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buy_and_sells)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buy_and_sell" do
    assert_difference('BuyAndSell.count') do
      post :create, buy_and_sell: {  }
    end

    assert_redirected_to buy_and_sell_path(assigns(:buy_and_sell))
  end

  test "should show buy_and_sell" do
    get :show, id: @buy_and_sell
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buy_and_sell
    assert_response :success
  end

  test "should update buy_and_sell" do
    put :update, id: @buy_and_sell, buy_and_sell: {  }
    assert_redirected_to buy_and_sell_path(assigns(:buy_and_sell))
  end

  test "should destroy buy_and_sell" do
    assert_difference('BuyAndSell.count', -1) do
      delete :destroy, id: @buy_and_sell
    end

    assert_redirected_to buy_and_sells_path
  end
end
