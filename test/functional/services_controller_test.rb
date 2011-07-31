require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  require 'fakeweb'
  include Devise::TestHelpers
  
  def setup
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:post, 'https://www.obsidianportal.com/oauth/request_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
    FakeWeb.register_uri(:post, 'https://www.obsidianportal.com/oauth/access_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
    FakeWeb.register_uri(:get, 'https://www.obsidianportal.com/oauth/authorize', :response => File.join(Rails.root.to_s, 'test', 'fixtures', 'authorize'))
    FakeWeb.register_uri(:get, 'http://api.obsidianportal.com/v1/users/me.json', :body => File.join(Rails.root.to_s, 'test', 'fixtures', 'op_user'))

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

  test "should get obsidian_connect" do
    sign_in(users(:one))
    
    post :obsidian_connect
    assert_redirected_to root_path
  end

  test "shouldn't get obsidian_connect" do
    post :obsidian_connect
    assert_redirected_to new_user_session_path
  end

  test "should get obsidian_disconnect" do
    sign_in(users(:one))
    
    post :obsidian_disconnect
    assert_redirected_to root_path
  end
  
  test "shouldn't get obsidian_disconnect" do
    post :obsidian_disconnect
    assert_redirected_to new_user_session_path
  end
end
