require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:name => "unique", :password => "pword" }
    end

    assert_redirected_to user_path(assigns(:user))
    assert_not_nil(User.find_by_name("unique"))
  end

  test "should show user" do
    login_as(users(:Storyteller))
    
    get :show, :id => users(:one).to_param
    assert_response :success, "didn't show user as ST"
    
    login_as(users(:one))
    
    get :show, :id => users(:one).to_param
    assert_response :success, "didn't show user as user"
  end
  
  test "shouldn't show user" do
    # when not logged in
    get :show, :id => users(:one).to_param
    assert_response :redirect, @response.body
    assert_equal("Please log in", flash[:notice], "got past authentication")

    # as other user
    login_as(users(:two))
    
    get :show, :id => users(:one).to_param
    assert_response :redirect, @response.body
    assert_equal("You don't have permission to do that", flash[:notice], "showed user that shouldn't have been shown")
  end

  test "should get edit" do
    # as storyteller
    login_as(users(:Storyteller))
    
    get :edit, :id => users(:one).to_param
    assert_response :success

    # as user
    login_as(users(:one))
    
    get :edit, :id => users(:one).to_param
    assert_response :success
  end
  
  test "shouldn't get edit" do
    # when not logged in
    get :edit, :id => users(:one).to_param
    assert_response :redirect, @response.body
    assert_equal("Please log in", flash[:notice], "got past authentication")

    # as other user
    login_as(users(:two))
    
    get :edit, :id => users(:one).to_param
    assert_response :redirect, @response.body
    assert_equal("You don't have permission to do that", flash[:notice], "edited user that shouldn't have been shown")
  end

  test "should update user" do
    # as ST
    login_as(users(:Storyteller))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_response :success

    # as user
    login_as(users(:one))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_response :success
  end
  
  test "shouldn't update user" do
    # when not logged in
    put :update, :id => users(:one).to_param, :user => { }
    assert_response :redirect, @response.body

    # as other user
    login_as(users(:two))
    
    put :update, :id => users(:one).to_param, :user => { }
    assert_redirected_to user_path(users(:two))
    assert_equal("You don't have permission to do that", flash[:notice], "updated user that shouldn't have been shown")
  end

  test "should destroy user as storyteller" do
    # as ST
    login_as(users(:Storyteller))
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to :controller => :characters
    
    # as own user
    login_as(users(:two))
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:two).to_param
    end

    assert_redirected_to :controller => :characters
  end
  
  test "shouldn't destroy user" do
    # when not logged in
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:one).to_param
    end

    assert_response :redirect, @response.body

    # as other user
    login_as(users(:two))
    
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to user_path(users(:two))
    assert_equal("You don't have permission to do that", flash[:notice], "destroyed other user")
  end
end
