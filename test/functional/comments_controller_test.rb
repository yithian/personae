require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end

  test "should get new" do
    login_as(users(:one))

    get :new, :character_id => characters(:one).id, :user => users(:one)
    assert_response :success, @response.message
  end
  
  test "shouldn't get new" do
    # when not logged in
    get :new, :character_id => characters(:one).id
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]

    login_as(users(:one))

    # character two isn't visible
    get :new, :character_id => characters(:two).id
    assert_redirected_to :controller => "characters", :action => "index"
  end
  
  test "should create comment" do
    login_as(users(:one))

    assert_difference('Comment.count', 1, :message => "didn't create comment") do
      post :create, { :character_id => characters(:one).id, :comment => { :character_id => characters(:one).id, :user_id => users(:one).id, :speaker => characters(:one).name, :body => "some words" } }
    end
    assert_redirected_to :controller => "characters", :action => "show", :id => characters(:one).id
  end

  test "shouldn't create comment" do
    # not logged in
    assert_no_difference('Comment.count', "got past authentication") do
      post :create, { :character_id => characters(:one).id, :comment => { :character_id => characters(:one).id, :user_id => users(:one).id, :speaker => characters(:one).name, :body => "some words" } }
    end
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]

    # character two isn't visible
    login_as(users(:one))

    assert_no_difference('Comment.count', "commented on character that shouldn't be visible") do
      post :create, { :character_id => characters(:two).id, :comment => { :character_id => characters(:two).id, :user_id => users(:one).id, :speaker => characters(:one).name, :body => "some words" } }
    end
    assert_redirected_to :controller => "characters", :action => "index"
  end

  test "should destroy comment" do
    # ST can remove all comments
    login_as(users(:Storyteller))
    
    assert_difference('Comment.count', -1, "ST didn't destroy comment") do
      delete :destroy, :id => comments(:one).id, :character_id => characters(:one).id
    end
    assert_redirected_to character_path(characters(:one))

    # destroy own comments
    login_as(users(:two))
    
    assert_difference('Comment.count', -1, "user didn't destroy own comment") do
      delete :destroy, :id => comments(:two).id, :character_id => characters(:two).id
    end
    assert_redirected_to character_path(characters(:two))
  end

  test "shouldn't destroy comment" do
    # logged out
    assert_no_difference('Comment.count', "got past authentication") do
      delete :destroy, :id => comments(:one).id, :character_id => characters(:one).id
    end
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]
    
    # destroy other user's comment
    login_as(users(:two))

    assert_no_difference('Comment.count', "deleted other user's comment") do
      delete :destroy, :id => comments(:one).id, :character_id => characters(:one).id
    end
    assert_redirected_to character_path(characters(:one))
    assert_equal "You don't have permission to do that", flash[:notice]
  end
end
