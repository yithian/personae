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
    assert_not_nil(User.find_by_name("unique"))
  end

  test "should show user as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    get :show, :id => users(:one).to_param
    assert_response :success
  end
  
  test "should show user as user" do
    st_setup
    login_as(users(:one))
    
    get :show, :id => users(:one).to_param
    assert_response :success
  end
  
  test "shouldn't show user as other user" do
    st_setup
    login_as(users(:two))
    
    get :show, :id => users(:one).to_param
    assert_response :redirect, @response.body
    assert_equal("You don't have permission to do that", flash[:notice], "showed user that shouldn't have been shown")
  end

  test "shouldn't show user when not logged in" do
    st_setup
    
    get :show, :id => users(:one).to_param
    assert_response :redirect, @response.body
    assert_equal("Please log in", flash[:notice], "got past authentication")
  end

  test "should get edit as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    get :edit, :id => users(:one).to_param
    assert_response :success
  end
  
  test "should get edit as user" do
    st_setup
    login_as(users(:one))
    
    get :edit, :id => users(:one).to_param
    assert_response :success
  end
  
  test "shouldn't get edit as other user" do
    st_setup
    login_as(users(:two))
    
    get :edit, :id => users(:one).to_param
    assert_response :redirect
    assert_equal("You don't have permission to do that", flash[:notice], "edited user that shouldn't have been shown")
  end

  test "shouldn't get edit when not logged in" do
    st_setup
    
    get :edit, :id => users(:one).to_param
    assert_response :redirect
    assert_equal("Please log in", flash[:notice], "got past authentication")
  end

  test "should update user as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_response :success
  end
  
  test "should update user as user" do
    st_setup
    login_as(users(:one))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_response :success
  end
  
  test "shouldn't update user as other user" do
    st_setup
    login_as(users(:two))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_redirected_to user_path(users(:two))
    assert_equal("You don't have permission to do that", flash[:notice], "updated user that shouldn't have been shown")
  end

  test "shouldn't update user when not logged in" do
    st_setup
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_response :redirect
  end

  test "should destroy user as storyteller" do
    st_setup
    login_as(User.find_by_name("Storyteller"))
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to :controller => :characters
  end
  
  test "should destroy user as user" do
    st_setup
    login_as(users(:one))
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to :controller => :characters
  end
  
  test "shouldn't destroy user as other user" do
    st_setup
    login_as(users(:two))
    
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to user_path(users(:two))
    assert_equal("You don't have permission to do that", flash[:notice], "destroyed other user")
  end

  test "shouldn't destroy user when not logged in" do
    st_setup
    login_as(users(:two))
    
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:one).to_param
    end

    assert_response :redirect
  end
end
