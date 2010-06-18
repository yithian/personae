require 'test_helper'

class IdeologiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ideologies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ideology" do
    assert_difference('Ideology.count') do
      post :create, :ideology => { }
    end

    assert_redirected_to ideology_path(assigns(:ideology))
  end

  test "should show ideology" do
    get :show, :id => ideologies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ideologies(:one).to_param
    assert_response :success
  end

  test "should update ideology" do
    put :update, :id => ideologies(:one).to_param, :ideology => { }
    assert_redirected_to ideology_path(assigns(:ideology))
  end

  test "should destroy ideology" do
    assert_difference('Ideology.count', -1) do
      delete :destroy, :id => ideologies(:one).to_param
    end

    assert_redirected_to ideologies_path
  end
end
