require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "shouldn't get manage" do
    get :manage
    assert_redirected_to new_user_session_path

    sign_in(users(:one))
    
    get :manage
    assert_redirected_to root_path
    assert_equal "Access denied!", flash[:error]
  end
  
  test "should get manage" do
    sign_in(users(:Storyteller))
    
    get :manage
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "shouldn't put manage" do
    put :manage
    assert_redirected_to new_user_session_path

    sign_in(users(:one))
    
    put :manage
    assert_redirected_to root_path
    assert_equal "Access denied!", flash[:error]
  end
  
  test "should put manage" do
    sign_in(users(:Storyteller))
    
    put :manage
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "shouldn't set admins" do
    put :manage,  :admin_ids => [users(:Storyteller).id, users(:one).id]
    
    assert_redirected_to new_user_session_path
    assert users(:one).admin == false

    sign_in(users(:one))
    put :manage, :admin_ids => [users(:Storyteller).id, users(:one).id]
    
    assert_redirected_to root_path
    assert User.find_by_id(users(:one).id).admin? == false, "user was set as admin"
  end

  test "should set admins" do
    sign_in(users(:Storyteller))

    post :manage, :admin_ids => [users(:Storyteller).id, users(:one).id]
    
    assert_response :success
    assert User.find_by_id(users(:one).id).admin? == true, "user was not set as admin"
  end

  test "shouldn't unset Storyteller" do
    sign_in(users(:Storyteller))

    post :manage, :admin_ids => [users(:one).id]
    
    assert_response :success
    assert User.find_by_id(users(:Storyteller).id).admin? == true, "Storyteller was unset as admin"
  end
end
