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

  test "shouldn't get index when not logged in" do
    st_setup
    
    get :index
    assert_response :redirect
  end

  test "should get new as user" do
    st_setup
    login_as(users(:one))
    
    get :new
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    st_setup
    
    get :new
    assert_response :redirect
  end

  test "should create clique as user" do
    st_setup
    login_as(users(:one))
    
    assert_difference('Clique.count') do
      post :create, :clique => { :name => "unique" }
    end

    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully created.", flash[:notice], "character wasn't updated"
  end

  test "shouldn't create clique when not logged in" do
    st_setup
    
    assert_no_difference('Clique.count') do
      post :create, :clique => { :name => "unique" }
    end

    assert_response :redirect
  end

  test "should show clique as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    get :show, :id => cliques(:one).to_param
    assert_response :success
  end

  test "should show clique as owning user" do
    st_setup
    login_as(users(:one))
    
    get :show, :id => cliques(:one).to_param
    assert_response :success
  end

  test "shouldn't show clique as other user" do
    st_setup
    login_as(users(:two))
    
    # clique two has write set to false
    get :show, :id => cliques(:two).to_param
    assert_response :redirect
    assert_equal "You don't have permission to do that", flash[:notice], "character was updated"
  end

  test "shouldn't show clique when not logged in" do
    st_setup
    
    get :show, :id => cliques(:one).to_param
    assert_response :redirect
  end

  test "should get edit as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    get :edit, :id => cliques(:one).to_param
    assert_response :success
  end

  test "should get edit as owning user" do
    st_setup
    login_as(users(:one))

    cliques(:one).user_id = users(:one).id
    cliques(:one).save
    
    get :edit, :id => cliques(:one).to_param
    assert_response :success
  end

  test "shouldn't get edit as non-owning user" do
    st_setup
    login_as(users(:one))
    
    get :edit, :id => cliques(:two).to_param
    assert_response :redirect
    assert_equal "You don't have permission to do that", flash[:notice], "character was updated"
  end

  test "shouldn't get edit when not logged in" do
    st_setup
    
    get :edit, :id => cliques(:two).to_param
    assert_response :redirect
  end

  test "should update clique as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "character wasn't updated"
  end

  test "should update clique as owning user" do
    st_setup
    login_as(users(:one))

    cliques(:one).user_id = users(:one).id
    cliques(:one).save
    
    put :update, :id => cliques(:one).to_param, :clique => { }
    assert_redirected_to clique_path(assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "character wasn't updated"
  end

  test "shouldn't update clique as non-owning user" do
    st_setup
    login_as(users(:two))
    
    cliques(:one).user_id = users(:one).id
    cliques(:one).save
    
    put :update, :id => cliques(:one).to_param, :clique => { }
    
    assert_redirected_to :controller => :cliques
    assert_equal "You don't have permission to do that", flash[:notice], "character was updated"
  end

  test "should destroy clique as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    assert_difference('Clique.count', -1) do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_redirected_to cliques_path
  end

  test "should destroy clique as owning user" do
    st_setup
    login_as(users(:one))
    
    cliques(:one).user_id = users(:one).id
    cliques(:one).save

    assert_difference('Clique.count', -1) do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_redirected_to cliques_path
  end

  test "shouldn't destroy clique as non-owning user" do
    st_setup
    login_as(users(:two))
    
    cliques(:one).user_id = users(:one).id
    cliques(:one).save

    assert_no_difference('Clique.count', -1) do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_redirected_to cliques_path
  end

  test "shouldn't destroy clique when not logged in" do
    st_setup
    
    cliques(:one).user_id = users(:one).id
    cliques(:one).save

    assert_no_difference('Clique.count', -1) do
      delete :destroy, :id => cliques(:one).to_param
    end

    assert_response :redirect
  end
end
