require 'test_helper'

class CliquesControllerTest < ActionController::TestCase
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end
  
  test "should get index" do
    login_as(users(:one))
    
    get :index
    assert_response :success
    assert_not_nil assigns(:cliques)
  end

  test "shouldn't get index" do
    get :index
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"
  end

  test "should get new" do
    login_as(users(:one))
    
    get :new
    assert_response :success
  end

  test "shouldn't get new" do
    get :new
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"
  end

  test "should create clique" do
    login_as(users(:one))
    
    assert_difference('Clique.count') do
      post :create, :clique => { :name => "unique" }
    end

    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully created.", flash[:notice], "clique wasn't updated"
  end

  test "shouldn't create clique" do
    assert_no_difference('Clique.count') do
      post :create, :clique => { :name => "unique" }
    end

    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"
  end

  test "should show clique" do
    # ST sees all cliques
    login_as(users(:Storyteller))
    
    get :show, :id => cliques(:one).to_param
    assert_response :success, "didn't show known clique as ST"
    get :show, :id => cliques(:two).to_param
    assert_response :success, "didn't show unknown clique as ST"

    # show clique as member
    login_as(users(:one))

    get :show, :id => cliques(:one).to_param
    assert_response :success, "didn't show known clique as owner"

    # show known clique as other user
    login_as(users(:two))

    get :show, :id => cliques(:two).to_param
    assert_response :success, "didn't show known clique"
  end

  test "shouldn't show clique" do
    # not logged in
    get :show, :id => cliques(:one).to_param
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"

    login_as(users(:one))
    
    # clique two has write set to false
    get :show, :id => cliques(:two).to_param
    assert_response :redirect
    assert_equal "You don't have permission to do that", flash[:notice], "showed unknown clique when logged in"
  end

  test "should get edit" do
    login_as(users(:Storyteller))
    
    get :edit, :id => cliques(:one).to_param
    assert_response :success

    # owning user
    login_as(users(:one))

    get :edit, :id => cliques(:one).to_param
    assert_response :success
  end

  test "shouldn't get edit" do
    # not logged in
    get :edit, :id => cliques(:two).to_param
    assert_response :redirect, "got edit when not logged in"

    # non-owning user
    login_as(users(:one))
    
    get :edit, :id => cliques(:two).to_param
    assert_response :redirect
    assert_equal "You don't have permission to do that", flash[:notice], "got edit as non-owning user"
  end

  test "should update clique" do
    # ST can update all
    login_as(users(:Storyteller))
    
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "clique wasn't updated as ST"
    
    # update owned clique
    login_as(users(:one))

    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "clique wasn't updated as owner"
  end

  test "shouldn't update clique" do
    # shouldn't update when not logged in
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"
    
    # shouldn't update as non-owning user
    login_as(users(:two))
    
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to :controller => :cliques
    assert_equal "You don't have permission to do that", flash[:notice], "clique was updated"
  end

  test "should destroy clique" do
    # ST can destroy all
    login_as(users(:Storyteller))
    
    assert_difference('Clique.count', -1, "ST couldn't destroy clique") do
      delete :destroy, :id => cliques(:one).to_param
    end
    assert_redirected_to cliques_path

    # destroy clique as owner
    login_as(users(:two))
    
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

    assert_response :redirect

    # shouldn't destroy as non-owning user
    login_as(users(:two))
    
    assert_no_difference('Clique.count', "destroyed as non-owning user") do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_redirected_to cliques_path
  end
end
