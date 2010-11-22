require 'test_helper'

class ChroniclesControllerTest < ActionController::TestCase
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end
  
  test "should get index" do
    login_as(users(:Storyteller))
    
    get :index
    assert_response :success
    assert_not_nil(assigns(:chronicles), "no chronicles assigned")
  end

  test "shouldn't get index" do
    get :index
    assert_redirected_to :controller => "admin", :action => "login"
    assert_nil assigns(:chronicles), "got past authentication"
  end

  test "should get new" do
    login_as(users(:Storyteller))
    
    get :new
    assert_response :success
  end
  
  test "shouldn't get new" do
    #not logged in
    get :new
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal("Please log in", flash[:notice])
    
    #logged in as user
    login_as(users(:one))
    
    get :new
    assert_response :redirect, @response.body
  end

  test "should create chronicle" do
    login_as(users(:Storyteller))
    
    assert_difference('Chronicle.count') do
      post :create, :chronicle => { :name => "Unique" }
    end

    assert_redirected_to chronicle_path(assigns(:chronicle))
  end
  
  test "shouldn't create chronicle" do
    assert_no_difference('Chronicle.count') do
      post :create, :chronicle => { :name => "Unique" }
    end

    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal("Please log in", flash[:notice])
    
    login_as(users(:one))
    assert_no_difference('Chronicle.count') do
      post :create, :chronicle => { :name => "Unique" }
    end

    assert_redirected_to :controller => "chronicles"
    assert_equal("You don't have permission to do that", flash[:notice])
  end

  test "should show chronicle" do
    login_as(users(:one))
    
    get :show, :id => chronicles(:one).to_param
    assert_response :success
  end
  
  test "shouldn't show chronicle" do
    get :show, :id => chronicles(:one).to_param
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal("Please log in", flash[:notice])
  end

  test "should get edit" do
    login_as(users(:Storyteller))
    
    get :edit, :id => chronicles(:one).to_param
    assert_response :success
  end
  
  test "shouldn't get edit" do
    get :edit, :id => chronicles(:one).to_param
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal("Please log in", flash[:notice])
    
    login_as(users(:one))
    get :edit, :id => chronicles(:one).to_param
    
    assert_redirected_to :controller => "chronicles", :action => "show", :id => chronicles(:one)
    assert_equal("You don't have permission to do that", flash[:notice])
  end

  test "should update chronicle" do
    login_as(users(:Storyteller))
    
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    assert_redirected_to chronicle_path(assigns(:chronicle))
  end
  
  test "shouldn't update chronicle" do
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal("Please log in", flash[:notice])
    
    login_as(users(:one))
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    
    assert_redirected_to :controller => "chronicles", :action => "show", :id => chronicles(:one)
    assert_equal("You don't have permission to do that", flash[:notice])
  end

  test "should destroy chronicle" do
    login_as(users(:Storyteller))
    
    assert_difference('Chronicle.count', -1) do
      delete :destroy, :id => chronicles(:one).to_param
    end

    assert_redirected_to chronicles_path
  end
  
  test "shouldn't destroy chronicle" do
    assert_no_difference "Chronicle.count" do
      delete :destroy, :id => chronicles(:one).to_param
    end
    
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal("Please log in", flash[:notice])
    
    login_as(users(:one))
    
    assert_no_difference "Chronicle.count" do
      delete :destroy, :id => chronicles(:one).to_param
    end
    
    assert_redirected_to :action => "index"
    assert_equal("You don't have permission to do that", flash[:notice])
  end
end
