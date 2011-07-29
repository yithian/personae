require 'test_helper'

class ChroniclesControllerTest < ActionController::TestCase
  require 'fakeweb'
  include Devise::TestHelpers

  def setup
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:post, 'https://www.obsidianportal.com/oauth/request_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
    FakeWeb.register_uri(:post, 'https://www.obsidianportal.com/oauth/access_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
    FakeWeb.register_uri(:get, 'https://www.obsidianportal.com/oauth/authorize', :response => File.join(Rails.root.to_s, 'test', 'fixtures', 'authorize'))
    FakeWeb.register_uri(:get, 'http://api.obsidianportal.com/v1/users/me.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_user'))
    FakeWeb.register_uri(:get, 'http://api.obsidianportal.com/v1/campaigns/1.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_campaign'))
    FakeWeb.register_uri(:get, 'http://api.obsidianportal.com/v1/campaigns/1/wikis.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_wiki'))
    FakeWeb.register_uri(:put, 'http://api.obsidianportal.com/v1/campaigns/1/wikis/1.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_wiki'))

    @request.session[:access_token_key] = "zbSBqRLcixlAVpdZ9DRQ"
    @request.session[:access_token_secret] = "XrkwQiAHQUl4U6Xzwx0mjXE90DtM4cXmz2jYDK2V"
  end
  
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
  end
  
  test "shouldn't get edit" do
    get :edit, :id => chronicles(:one).to_param
    assert_login
    
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
    
    assert_login
    
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
    
    assert_login
    
    sign_in(users(:one))
    
    assert_no_difference "Chronicle.count" do
      delete :destroy, :id => chronicles(:one).to_param
    end
    
    assert_redirected_to chronicle_path(chronicles(:one))
    assert_equal("Access denied!", flash[:error])
  end
end
