require 'test_helper'

class CliquesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cliques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clique" do
    assert_difference('Clique.count') do
      post :create, :clique => { }
    end

    assert_redirected_to clique_path(assigns(:clique))
  end

  test "should show clique" do
    get :show, :id => cliques(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cliques(:one).to_param
    assert_response :success
  end

  test "should update clique" do
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
  end

  test "should destroy clique" do
    assert_difference('Clique.count', -1) do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_redirected_to cliques_path
  end
end
