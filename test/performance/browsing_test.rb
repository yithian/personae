require 'test_helper'
require 'rails/performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class BrowsingTest < ActionDispatch::PerformanceTest
  def login(user)
    get '/users/sign_in'
    assert_response :success, @response.body

    post_via_redirect '/users/sign_in', :name => user.name, :password => user.password
    assert_response :success, @response.body
  end

  def test_homepage
    get '/'
  end

  def test_homepage_while_logged_in
    login users(:one)

    get '/'
  end
end
