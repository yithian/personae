require 'test_helper'

class ChroniclesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should get index" do
    sign_in(users(:Storyteller))
    
    get :index
    assert_response :success
    assert_not_nil(assigns(:chronicles), "no chronicles assigned")
  end

  test "shouldn't get index" do
    get :index
    assert_redirected_to new_user_session_path
    assert_nil assigns(:chronicles), "got past authentication"
  end

  test "should get new" do
    sign_in(users(:Storyteller))
    
    get :new
    assert_response :success
    
    #logged in as user
    sign_in(users(:one))
    
    get :new
    assert_response :success
  end
  
  test "shouldn't get new" do
    #not logged in
    get :new
    assert_redirected_to new_user_session_path
    assert_equal("You need to sign in or sign up before continuing.", flash[:alert])
  end

  test "should create chronicle" do
    sign_in(users(:Storyteller))
    
    assert_difference('Chronicle.count') do
      post :create, :chronicle => { :name => "Unique" }
    end

    assert_redirected_to chronicle_path(assigns(:chronicle))
    
    sign_in(users(:one))
    assert_difference('Chronicle.count') do
      post :create, :chronicle => { :name => "Other" }
    end

    assert_redirected_to chronicle_path(assigns(:chronicle))
  end
  
  test "shouldn't create chronicle" do
    assert_no_difference('Chronicle.count') do
      post :create, :chronicle => { :name => "Unique" }
    end

    assert_redirected_to new_user_session_path
    assert_equal("You need to sign in or sign up before continuing.", flash[:alert])
  end

  test "should show chronicle" do
    get :show, :id => chronicles(:one).to_param
    assert_response :success, @response

    sign_in(users(:one))
    
    get :show, :id => chronicles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in(users(:Storyteller))
    
    get :edit, :id => chronicles(:one).to_param
    assert_response :success
  end
  
  test "shouldn't get edit" do
    get :edit, :id => chronicles(:one).to_param
    assert_redirected_to new_user_session_path
    assert_equal("You need to sign in or sign up before continuing.", flash[:alert])
    
    sign_in(users(:one))
    get :edit, :id => chronicles(:one).to_param
    
    assert_redirected_to chronicle_path(chronicles(:one))
    assert_equal("Access denied!", flash[:error])
  end

  test "should update chronicle" do
    sign_in(users(:Storyteller))
    
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    assert_redirected_to chronicle_path(assigns(:chronicle))
  end
  
  test "shouldn't update chronicle" do
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    
    assert_redirected_to new_user_session_path
    assert_equal("You need to sign in or sign up before continuing.", flash[:alert])
    
    sign_in(users(:one))
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    
    assert_redirected_to chronicle_path(chronicles(:one))
    assert_equal("Access denied!", flash[:error])
  end

  test "should destroy chronicle" do
    sign_in(users(:Storyteller))
    
    assert_difference('Chronicle.count', -1) do
      delete :destroy, :id => chronicles(:one).to_param
    end

    assert_redirected_to chronicles_path
  end
  
  test "shouldn't destroy chronicle" do
    assert_no_difference "Chronicle.count" do
      delete :destroy, :id => chronicles(:one).to_param
    end
    
    assert_redirected_to new_user_session_path
    assert_equal("You need to sign in or sign up before continuing.", flash[:alert])
    
    sign_in(users(:one))
    
    assert_no_difference "Chronicle.count" do
      delete :destroy, :id => chronicles(:one).to_param
    end
    
    assert_redirected_to chronicle_path(chronicles(:one))
    assert_equal("Access denied!", flash[:error])
  end
end
