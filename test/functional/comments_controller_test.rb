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

  test "should get edit" do
    # storyteller can edit all comments
    login_as(users(:Storyteller))

    get :edit, :id => comments(:one).id, :character_id => characters(:one).id
    assert_response :success, @response.message

    # owner of the comment
    login_as(users(:one))

    get :edit, :id => comments(:one).id, :character_id => characters(:one).id
    assert_response :success, @response.message
  end

  test "shouldn't get edit" do
    # not logged in
    get :edit, { :id => comments(:one).id, :character_id => characters(:one).id }
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]

    # character two isn't public
    login_as(users(:one))

    get :edit, { :id => comments(:two).id, :character_id => characters(:two).id }
    assert_redirected_to :controller => "characters", :action => "index"
    assert_equal "You don't have permission to do that", flash[:notice]
  end

  test "should update comment" do
    login_as(users(:one))

    put :update, :id => comments(:one).id, :character_id => characters(:one).id, :comment => { :body => "updated text" }
    assert_redirected_to :controller => "characters", :action => "show", :id => characters(:one).id
  end
end
