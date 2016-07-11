require 'test_helper'

class IdeologiesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def assert_login
    assert_redirected_to new_user_session_path
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end

  def assert_denied
    assert_redirected_to root_path
    assert_equal 'Access denied!', flash[:error]
  end

  test 'should get index' do
    # sign_in(users(:one))

    get :index
    assert_response :success, @response
    assert_not_nil assigns(:ideologies)

    sign_in(users(:one))

    get :index
    assert_response :success, @response
    assert_not_nil assigns(:ideologies)
  end

  test 'should get new' do
    sign_in(users(:Storyteller))

    get :new, params: {splat_id: splats(:one).id}
    assert_response :success
  end

  test 'shouldn\'t get new as nobody' do
    # when not logged in
    get :new
    assert_login
  end

  test 'shouldn\'t get new as user' do
    # or when logged in
    sign_in(users(:one))

    get :new
    assert_redirected_to ideologies_path
    assert_equal 'Access denied!', flash[:error], 'got new as user'
  end

  test 'should create ideology' do
    sign_in(users(:Storyteller))

    assert_difference('Ideology.count') do
      post :create, params: {ideology: { name: 'test' }}
    end

    assert_redirected_to ideology_path(assigns(:ideology))
  end

  test 'shouldn\'t create ideology as nobody' do
    # not logged in
    assert_no_difference('Ideology.count', 'created when not logged in') do
      post :create, params: {ideology: { name: 'test' }}
    end
    assert_login
  end

  test 'shouldn\'t create ideology as user' do
    # shouldn\'t create as user
    sign_in(users(:one))

    assert_no_difference('Ideology.count') do
      post :create, params: {ideology: { name: 'test' }}
    end
    assert_redirected_to ideologies_path
    assert_equal 'Access denied!', flash[:error], 'created ideology as user'
  end

  test 'should show ideology' do
    # when not logged in
    get :show, params: {id: ideologies(:two).to_param}
    assert_response :success, @response.body

    # should get ideology
    sign_in(users(:one))

    get :show, params: {id: ideologies(:one).to_param}
    assert_response :success, @response
  end

  test 'should get edit' do
    sign_in(users(:Storyteller))

    get :edit, params: {id: ideologies(:one).to_param}
    assert_response :success, @response
  end

  test 'shouldn\'t get edit as nobody' do
    # shouldn\'t get edit when not logged in
    get :edit, params: {id: ideologies(:one).to_param}
    assert_login
  end

  test 'shouldn\'t get edit as user' do
    # shouldn\'t get edit as user
    sign_in(users(:one))

    get :edit, params: {id: ideologies(:one).to_param}
    assert_redirected_to ideology_path(ideologies(:one))
    assert_equal 'Access denied!', flash[:error], 'got edit for ideology as user'
  end

  test 'should update ideology' do
    sign_in(users(:Storyteller))

    put :update, params: {id: ideologies(:one).to_param, ideology: { name: 'tested' }}
    assert_redirected_to ideology_path(assigns(:ideology))
  end

  test 'shouldn\'t update ideology as nobody' do
    put :update, params: {id: ideologies(:one).to_param, ideology: { name: 'tested' }}
    assert_login
  end

  test 'shouldn\'t update ideology as user' do
    sign_in(users(:one))
    put :update, params: {id: ideologies(:one).to_param, ideology: { name: 'tested' }}
    assert_equal('Access denied!', flash[:error], 'updated ideology as user')
    assert_redirected_to ideology_path(ideologies(:one))
  end

  test 'should destroy ideology' do
    sign_in(users(:Storyteller))

    assert_difference('Ideology.count', -1) do
      delete :destroy, params: {id: ideologies(:one).to_param}
    end

    assert_redirected_to ideologies_path
  end

  test 'shouldn\'t destroy ideology as nobody' do
    assert_no_difference('Ideology.count', 'got past authentication') do
      delete :destroy, params: {id: ideologies(:one).to_param}
    end

    assert_login
  end

  test 'shouldn\'t destroy ideology as user' do
    sign_in(users(:one))

    assert_no_difference('Ideology.count', 'user destroyed ideology') do
      delete :destroy, params: {id: ideologies(:one).to_param}
    end
    assert_redirected_to ideology_path(ideologies(:one))
    assert_equal 'Access denied!', flash[:error]
  end
end
