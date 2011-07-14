require 'test_helper'

class CliquesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def assert_login
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  def assert_denied
    assert_redirected_to root_path
    assert_equal "Access denied!", flash[:error]
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cliques)

    sign_in(users(:one))
    
    get :index
    assert_response :success
    assert_not_nil assigns(:cliques)
  end

  test "should get new" do
    sign_in(users(:one))
    
    get :new, :chronicle_id => chronicles(:one).id
    assert_response :success
    assert_not_nil assigns(:clique)
  end

  test "shouldn't get new" do
    get :new
    assert_login
  end

  test "should create clique" do
    sign_in(users(:one))
    
    assert_difference('Clique.count') do
      post :create, :clique => { :name => "unique" }
    end

    assert_redirected_to clique_path(assigns(:clique))
    assert_not_nil assigns(:clique)
    assert_equal "Clique was successfully created.", flash[:notice], "clique wasn't updated"
  end

  test "shouldn't create clique" do
    assert_no_difference('Clique.count') do
      post :create, :clique => { :name => "unique" }
    end

    assert_login
  end

  test "should show clique" do
    # not logged in
    get :show, :id => cliques(:one).to_param
    assert_response :success, @response.body
    assert_not_nil assigns(:clique)
    
    # ST sees all cliques
    sign_in(users(:Storyteller))
    
    get :show, :id => cliques(:one).to_param
    assert_response :success, @response
    assert_not_nil assigns(:clique)
    get :show, :id => cliques(:two).to_param
    assert_response :success, @response
    assert_not_nil assigns(:clique)

    # show clique as member
    sign_in(users(:one))

    get :show, :id => cliques(:one).to_param
    assert_response :success, @response
    assert_not_nil assigns(:clique)

    # show known clique as other user
    sign_in(users(:two))

    get :show, :id => cliques(:two).to_param
    assert_response :success, @repsonse
    assert_not_nil assigns(:clique)
  end

  test "shouldn't show clique" do
    sign_in(users(:one))
    
    # clique two has write set to false
    get :show, :id => cliques(:two).to_param
    assert_redirected_to cliques_path
    assert_equal "You don't have permission to do that", flash[:notice], "showed unknown clique when logged in"
  end

  test "should get edit" do
    sign_in(users(:Storyteller))
    
    get :edit, :id => cliques(:one).to_param
    assert_response :success, @response

    # owning user
    sign_in(users(:one))

    get :edit, :id => cliques(:one).to_param
    assert_response :success, @response
  end

  test "shouldn't get edit" do
    # not logged in
    get :edit, :id => cliques(:two).to_param
    assert_login

    # non-owning user
    sign_in(users(:one))
    
    get :edit, :id => cliques(:two).to_param
    assert_redirected_to clique_path(cliques(:two))
    assert_equal "Access denied!", flash[:error], "got edit as non-owning user"
  end

  test "should update clique" do
    # ST can update all
    sign_in(users(:Storyteller))
    
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "clique wasn't updated as ST"
    
    # update owned clique
    sign_in(users(:one))

    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "clique wasn't updated as owner"
  end

  test "shouldn't update clique" do
    # shouldn't update when not logged in
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_login
    
    # shouldn't update as non-owning user
    sign_in(users(:one))
    
    put :update, :id => cliques(:two).to_param, :clique => { }
    assert_redirected_to clique_path(cliques(:two))
    assert_equal "Access denied!", flash[:error], "clique was updated"
  end

  test "should destroy clique" do
    # ST can destroy all
    sign_in(users(:Storyteller))
    
    assert_difference('Clique.count', -1, "ST couldn't destroy clique") do
      delete :destroy, :id => cliques(:one).to_param
    end
    assert_redirected_to cliques_path

    # destroy clique as owner
    sign_in(users(:two))
    
    assert_difference('Clique.count', -1, "owning user couldn't destroy clique") do
      delete :destroy, :id => cliques(:two).to_param
    end
    assert_redirected_to cliques_path
  end

  test "shouldn't destroy clique" do
    # shouldn't destroy when not logged in
    assert_no_difference('Clique.count', "destroyed when not logged in") do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_login

    # shouldn't destroy as non-owning user
    sign_in(users(:two))
    
    assert_no_difference('Clique.count', "destroyed as non-owning user") do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_redirected_to clique_path(cliques(:one))
    assert_equal("Access denied!", flash[:error])
  end
end
