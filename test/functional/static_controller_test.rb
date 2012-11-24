require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selected_chronicles)
  end
end
