require 'test_helper'

class AdminControllerTest < ActionController::TestCase
   def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end

  test "should log in" do
    post :login, :name => "Storyteller", :password => "worldofdarkness"
    
    assert_response :success, @response.message
  end

  test "shouldn't log in" do
    post :login, :name => "IjustmadethisUp", :password => "don'tgotone"

    assert_nil session[:user_id], "somehow got a user id in the session"
    assert_equal "Invalid user/password combination", flash[:notice]
  end

  test "should log out" do
    login_as(users(:Storyteller))

    get :logout
    assert_equal :logged_out, session[:user_id], "still have a user id in session"
    assert_equal "Logged out", flash[:notice]
  end
end
