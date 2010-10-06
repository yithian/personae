require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end

  test "should get new" do
    login_as(users(:one))

    get :new
    assert_response :success, @response.message
  end
end
