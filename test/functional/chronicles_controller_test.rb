require 'test_helper'

class ChroniclesControllerTest < ActionController::TestCase
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
    assert_response :success, @response

    sign_in(users(:Storyteller))
    
    get :index
    assert_response :success, @response
    assert_not_nil(assigns(:chronicles), "no chronicles assigned")
    
    # asserts the change_chronicle dropdown works
    assert_select "select" do |elements|
      elements.each do |element|
        assert_select element, "option", {:minimum => 1}
      end
    end
  end

  test "should get new" do
    sign_in(users(:Storyteller))
    
    get :new
    assert_response :success, @response
    
    #logged in as user
    sign_in(users(:one))
    
    get :new
    assert_response :success, @response
  end
  
  test "shouldn't get new" do
    #not logged in
    get :new
    assert_login
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

    assert_login
  end

  test "should show chronicle" do
    get :show, :id => chronicles(:one).to_param
    assert_response :success, @response
    assert_not_nil assigns(:chronicle)

    sign_in(users(:one))
    
    get :show, :id => chronicles(:one).to_param
    assert_response :success, @response
    assert_not_nil assigns(:chronicle)
  end

  test "should get edit" do
    sign_in(users(:Storyteller))

    get :edit, :id => chronicles(:one).to_param
    assert_response :success, @response
    assert_not_nil assigns(:chronicle)
    assert_not_nil(assigns(:users))
  end
  
  test "shouldn't get edit as nobody" do
    get :edit, :id => chronicles(:one).to_param
    assert_login
  end

  test "shouldn't get edit for other users' chronicles" do
    sign_in(users(:one))
    get :edit, :id => chronicles(:one).to_param
    
    assert_redirected_to chronicle_path(chronicles(:one))
    assert_equal("Access denied!", flash[:error])
  end

  test "should update chronicle" do
    sign_in(users(:Storyteller))
    

    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique", :owner_id => users(:two).id }
    assert_redirected_to chronicle_path(assigns(:chronicle))
  end
  
  test "shouldn't update chronicle" do
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    
    assert_login
  end

  test "shouldn't update other users' chronicles" do  
    sign_in(users(:one))
    put :update, :id => chronicles(:one).to_param, :chronicle => { :name => "Unique" }
    
    assert_redirected_to chronicles(:one)
    assert_equal("Access denied!", flash[:error])
    assert_not_equal("Unique", Chronicle.find_by_id(chronicles(:one).id).name)
  end

  test "should destroy chronicle" do
    sign_in(users(:Storyteller))
    
    assert_difference('Chronicle.count', -1) do
      delete :destroy, :id => chronicles(:one).to_param
    end

    assert_redirected_to chronicles_path
  end
  
  test "shouldn't destroy chronicle as nobody" do
    assert_no_difference "Chronicle.count" do
      delete :destroy, :id => chronicles(:one).to_param
    end
    
    assert_login
  end

  test "shouldn't destroy other users' chronicles" do
    sign_in(users(:one))
    
    assert_no_difference "Chronicle.count" do
      delete :destroy, :id => chronicles(:one).to_param
    end
    
    assert_redirected_to chronicles(:one)
    assert_equal("Access denied!", flash[:error])
    assert Chronicle.find_by_id(chronicles(:one).id)
  end
end
