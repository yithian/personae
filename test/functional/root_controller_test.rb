require 'test_helper'

class RootControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get root as nobody" do
    get :root
    
    assert_redirected_to chronicle_characters_path(Chronicle.first)
  end

  test "should get root as user" do
    sign_in(users(:one))

    get :root
    assert_redirected_to chronicle_characters_path(users(:one).selected_chronicle)
  end
end
