require 'test_helper'

class CliquesControllerTest < ActionController::TestCase
  def st_setup
    User.create(:name => "Storyteller", :password => "pword")
  end

  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end
  
  test "should get index as user" do
    st_setup
    login_as(users(:one))
    
    get :index
    assert_response :success
    assert_not_nil assigns(:cliques)
  end

  test "should get new as user" do
    st_setup
    login_as(users(:one))
    
    get :new
    assert_response :success
  end

  test "should create clique as user" do
    st_setup
    login_as(users(:one))
    
    assert_difference('Clique.count') do
      post :create, :clique => { :name => "unique" }
    end

    assert_redirected_to clique_path(assigns(:clique))
  end

  test "should show as correct clique" do
    st_setup
    login_as(users(:one))
    
    get :show, :id => cliques(:one).to_param
    assert_response :success
  end

  test "should get edit as correct user" do
    st_setup
    login_as(users(:one))
    
    get :edit, :id => cliques(:one).to_param
    assert_response :success
  end

  test "should update clique as correct user" do
    st_setup
    login_as(users(:one))
    
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
  end

  test "should destroy clique as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    assert_difference('Clique.count', -1) do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_redirected_to cliques_path
  end
end
