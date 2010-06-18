require 'test_helper'

class CabalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cabals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cabal" do
    assert_difference('Cabal.count') do
      post :create, :cabal => { }
    end

    assert_redirected_to cabal_path(assigns(:cabal))
  end

  test "should show cabal" do
    get :show, :id => cabals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cabals(:one).to_param
    assert_response :success
  end

  test "should update cabal" do
    put :update, :id => cabals(:one).to_param, :cabal => { }
    assert_redirected_to cabal_path(assigns(:cabal))
  end

  test "should destroy cabal" do
    assert_difference('Cabal.count', -1) do
      delete :destroy, :id => cabals(:one).to_param
    end

    assert_redirected_to cabals_path
  end
end
