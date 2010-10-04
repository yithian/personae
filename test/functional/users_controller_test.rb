require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def st_setup
    User.create(:name => "Storyteller", :password => "pword")
  end
  
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end
  
  test "should get new" do
    st_setup
    
    get :new
    assert_response :success
  end

  test "should create user" do
    st_setup
    
    assert_difference('User.count') do
      post :create, :user => {:name => "unique", :password => "pword" }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    st_setup
    login_as(users(:one))
    
    get :show, :id => users(:one).to_param
    assert_response :success
  end
  
  test "shouldn't show user" do
    st_setup
    
    get :show, :id => users(:one).to_param
    assert_response :redirect, @response.body
  end

  test "should get edit" do
    st_setup
    
    login_as(users(:one))
    
    get :edit, :id => users(:one).to_param
    assert_response :success
  end
  
  test "shouldn't get edit" do
    st_setup
    
    get :edit, :id => users(:one).to_param
    assert_response :redirect
  end

  test "should update user" do
    st_setup
    login_as(users(:one))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_response :success
  end
  
  test "shouldn't update another user" do
    st_setup
    login_as(users(:two))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_redirected_to user_path(users(:two))
  end

  test "should destroy user" do
    st_setup
    login_as(users(:one))
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to :controller => :characters
  end
  
  test "shouldn't destroy another user" do
    st_setup
    login_as(users(:two))
    
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to user_path(users(:two))
  end
end
