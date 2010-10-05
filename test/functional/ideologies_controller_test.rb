require 'test_helper'

class IdeologiesControllerTest < ActionController::TestCase
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end

  test "should get index" do
    login_as(users(:one))

    get :index
    assert_response :success
    assert_not_nil assigns(:ideologies)
  end

  test "shouldn't get index" do
    # when not logged in
    get :index
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"
  end

  test "should get new" do
    login_as(users(:Storyteller))
    
    get :new
    assert_response :success
  end

  test "shouldn't get new" do
    # when not logged in
    get :new
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"

    # or when logged in
    login_as(users(:one))

    get :new
    assert_redirected_to :action => :index
    assert_equal "You don't have permission to do that", flash[:notice], "got new as user"
  end

  test "should create ideology" do
    login_as(users(:Storyteller))

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
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"

    # shouldn't create as user
    login_as(users(:one))

    assert_no_difference('Ideology.count') do
      post :create, :ideology => { }
    end
    assert_redirected_to :controller => :ideologies, :action => :index
    assert_equal "You don't have permission to do that", flash[:notice], "created ideology as user"
  end

  test "should show ideology" do
    login_as(users(:Storyteller))

    get :show, :id => ideologies(:one).to_param
    assert_response :success

    # should get known ideology
    login_as(users(:one))

    get :show, :id => ideologies(:one).to_param
    assert_response :success
  end

  test "shouldn't show ideology" do
    # when not logged in
    get :show, :id => ideologies(:one).to_param
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"

    # shouldn't show unknown ideology
    login_as(users(:one))

    get :show, :id => ideologies(:two).to_param
    assert_redirected_to :action => :index
    assert_equal "You don't have permission to do that", flash[:notice], "showed unknown ideology"
  end

  test "should get edit" do
    login_as(users(:Storyteller))

    get :edit, :id => ideologies(:one).to_param
    assert_response :success
  end

  test "shouldn't get edit" do
    # shouldn't get edit when not logged in
    get :edit, :id => ideologies(:one).to_param
    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice], "got past authentication"

    # shouldn't get edit as user
    login_as(users(:one))

    get :edit, :id => ideologies(:one).to_param
    assert_redirected_to :action => :index
    assert_equal "You don't have permission to do that", flash[:notice], "got edit for ideology as user"
  end

  test "should update ideology" do
    login_as(users(:Storyteller))

    put :update, :id => ideologies(:one).to_param, :ideology => { }
    assert_redirected_to ideology_path(assigns(:ideology))
  end

  test "shouldn't update ideology" do
    put :update, :id => ideologies(:one).to_param, :ideology => { }
    assert_redirected_to :controller => :admin, :action => :login

    login_as(users(:one))
    put :update, :id => ideologies(:one).to_param, :ideology => { }
    assert_redirected_to :action => :index
  end

  test "should destroy ideology" do
    login_as(users(:Storyteller))

    assert_difference('Ideology.count', -1) do
      delete :destroy, :id => ideologies(:one).to_param
    end

    assert_redirected_to ideologies_path
  end

  test "shouldn't destroy ideology" do
    assert_no_difference('Ideology.count', "got past authentication") do
      delete :destroy, :id => ideologies(:one).to_param
    end

    assert_redirected_to :controller => :admin, :action => :login
    assert_equal "Please log in", flash[:notice]

    login_as(users(:one))

    assert_no_difference('Ideology.count', "user destroyed ideology") do
      delete :destroy, :id => ideologies(:one).to_param
    end
    assert_equal "You don't have permission to do that", flash[:notice]
  end
end
