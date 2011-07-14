require 'test_helper'

class IdeologiesControllerTest < ActionController::TestCase
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
    # sign_in(users(:one))

    get :index
    assert_response :success, @response
    assert_not_nil assigns(:ideologies)

    sign_in(users(:one))

    get :index
    assert_response :success, @response
    assert_not_nil assigns(:ideologies)
  end

  test "should get new" do
    sign_in(users(:Storyteller))
    
    get :new, :splat_id => splats(:one).id
    assert_response :success
  end

  test "shouldn't get new" do
    # when not logged in
    get :new
    assert_login

    # or when logged in
    sign_in(users(:one))

    get :new
    assert_redirected_to ideologies_path
    assert_equal "Access denied!", flash[:error], "got new as user"
  end

  test "should create ideology" do
    sign_in(users(:Storyteller))

    assert_difference('Ideology.count') do
      post :create, :ideology => { :name => "test" }
    end

    assert_redirected_to ideology_path(assigns(:ideology))
  end

  test "shouldn't create ideology" do
    # not logged in
    assert_no_difference('Ideology.count', "created when not logged in") do
      post :create, :ideology => { :name => "test" }
    end
    assert_login

    # shouldn't create as user
    sign_in(users(:one))

    assert_no_difference('Ideology.count') do
      post :create, :ideology => { :name => "test" }
    end
    assert_redirected_to ideologies_path
    assert_equal "Access denied!", flash[:error], "created ideology as user"
  end

  test "should show ideology" do
    # when not logged in
    get :show, :id => ideologies(:two).to_param
    assert_response :success, @response.body

    # should get ideology
    sign_in(users(:one))

    get :show, :id => ideologies(:one).to_param
    assert_response :success, @response
  end

  test "should get edit" do
    sign_in(users(:Storyteller))

    get :edit, :id => ideologies(:one).to_param
    assert_response :success, @response
  end

  test "shouldn't get edit" do
    # shouldn't get edit when not logged in
    get :edit, :id => ideologies(:one).to_param
    assert_login

    # shouldn't get edit as user
    sign_in(users(:one))

    get :edit, :id => ideologies(:one).to_param
    assert_redirected_to ideology_path(ideologies(:one))
    assert_equal "Access denied!", flash[:error], "got edit for ideology as user"
  end

  test "should update ideology" do
    sign_in(users(:Storyteller))

    put :update, :id => ideologies(:one).to_param, :ideology => { }
    assert_redirected_to ideology_path(assigns(:ideology))
  end

  test "shouldn't update ideology" do
    put :update, :id => ideologies(:one).to_param, :ideology => { }
    assert_login

    sign_in(users(:one))
    put :update, :id => ideologies(:one).to_param, :ideology => { }
    assert_equal("Access denied!", flash[:error], "updated ideology as user")
    assert_redirected_to ideology_path(ideologies(:one))
  end

  test "should destroy ideology" do
    sign_in(users(:Storyteller))

    assert_difference('Ideology.count', -1) do
      delete :destroy, :id => ideologies(:one).to_param
    end

    assert_redirected_to ideologies_path
  end

  test "shouldn't destroy ideology" do
    assert_no_difference('Ideology.count', "got past authentication") do
      delete :destroy, :id => ideologies(:one).to_param
    end

    assert_login

    sign_in(users(:one))

    assert_no_difference('Ideology.count', "user destroyed ideology") do
      delete :destroy, :id => ideologies(:one).to_param
    end
    assert_redirected_to ideology_path(ideologies(:one))
    assert_equal "Access denied!", flash[:error]
  end
end
