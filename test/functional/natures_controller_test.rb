require 'test_helper'

class NaturesControllerTest < ActionController::TestCase
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
    assert_not_nil assigns(:natures)

    sign_in(users(:one))

    get :index
    assert_response :success, @response
    assert_not_nil assigns(:natures)
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
    assert_redirected_to natures_path
    assert_equal 'Access denied!', flash[:error], 'got new as user'
  end

  test 'should create nature' do
    sign_in(users(:Storyteller))

    assert_difference('Nature.count') do
      post :create, params: {nature: { name: 'test' }}
    end

    assert_redirected_to nature_path(assigns(:nature))
  end

  test 'shouldn\'t create nature as nobody' do
    # not logged in
    assert_no_difference('Nature.count', 'created when not logged in') do
      post :create, params: {nature: { name: 'test' }}
    end
    assert_login
  end

  test 'shouldn\'t create nature as user' do
    # shouldn't create as user
    sign_in(users(:one))

    assert_no_difference('Nature.count') do
      post :create, params: {nature: { name: 'test' }}
    end
    assert_redirected_to natures_path
    assert_equal 'Access denied!', flash[:error], 'created nature as user'
  end

  test 'should show nature' do
    # when not logged in
    get :show, params: {id: natures(:two).to_param}
    assert_response :success, @response.body

    # should get nature
    sign_in(users(:one))

    get :show, params: {id: natures(:one).to_param}
    assert_response :success, @response
  end

  test 'should get edit' do
    sign_in(users(:Storyteller))

    get :edit, params: {id: natures(:one).to_param}
    assert_response :success, @response
  end

  test 'shouldn\'t get edit as nobody' do
    # shouldn't get edit when not logged in
    get :edit, params: {id: natures(:one).to_param}
    assert_login
  end

  test 'shouldn\'t get edit as user' do
    # shouldn't get edit as user
    sign_in(users(:one))

    get :edit, params: {id: natures(:one).to_param}
    assert_redirected_to nature_path(natures(:one))
    assert_equal 'Access denied!', flash[:error], 'got edit for nature as user'
  end

  test 'should update nature' do
    sign_in(users(:Storyteller))

    patch :update, params: {id: natures(:one).to_param, nature: { splat_id: splats(:one) }}
    assert_redirected_to nature_path(assigns(:nature))
  end

  test 'shouldn\'t update nature as nobody' do
    patch :update, params: {id: natures(:one).to_param, nature: { splat_id: splats(:one) }}
    assert_login
  end

  test 'shouldn\'t update nature as user' do
    sign_in(users(:one))
    patch :update, params: {id: natures(:one).to_param, nature: { splat_id: splats(:one) }}
    assert_equal('Access denied!', flash[:error], 'updated nature as user')
    assert_redirected_to nature_path(natures(:one))
  end

  test 'should destroy nature' do
    sign_in(users(:Storyteller))

    assert_difference('Nature.count', -1) do
      delete :destroy, params: {id: natures(:one).to_param}
    end

    assert_redirected_to natures_path
  end

  test 'shouldn\'t destroy nature as nobody' do
    assert_no_difference('Nature.count', 'got past authentication') do
      delete :destroy, params: {id: natures(:one).to_param}
    end

    assert_login
  end

  test 'shouldn\'t destroy nature as user' do
    sign_in(users(:one))

    assert_no_difference('Nature.count', 'user destroyed nature') do
      delete :destroy, params: {id: natures(:one).to_param}
    end
    assert_redirected_to nature_path(natures(:one))
    assert_equal 'Access denied!', flash[:error]
  end
end
