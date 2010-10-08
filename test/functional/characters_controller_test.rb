require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  def login_as(user)
    @request.session[:user_id] = user ? user.id : nil
  end

  def foreign_keys
    # returns splat_id, clique_id, ideology_id, user_id, nature_id
  end

  test "should get index" do
    login_as(users(:one))

    get :index
    assert_response :success
    assert_not_nil assigns(:characters)
  end

  test "shouldn't get index" do
    get :index
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]
    assert_nil assigns(:characters), "got past authentication"
  end

  test "should get new" do
    login_as(users(:one))

    get :new, :splat_id => splats(:one).id
    assert_response :success
  end

  test "shouldn't get new" do
    get :new
    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]
  end

  test "should create character" do
    login_as(users(:one))

    assert_difference('Character.count') do
      post :create, :character => { :name => "unique", :splat_id => splats(:one).id }
    end

    assert_redirected_to character_path(assigns(:character))
  end

  test "shouldn't create character" do
    assert_no_difference('Character.count') do
      post :create, :character => { }
    end

    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]
  end

  test "should show character" do
    # ST can see all characters
    login_as(users(:Storyteller))

    get :show, :id => characters(:two).to_param
    assert_response :success

    # can see own characters
    login_as(users(:one))

    get :show, :id => characters(:one).to_param
    assert_response :success
  end

  test "shouldn't show character" do
    # not logged in
    get :show, :id => characters(:one).to_param

    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]

    # can't see hidden character
    login_as(users(:two))

    get :show, :id => characters(:two).to_param

    assert_redirected_to :controller => "characters", :action => "index"
    assert_equal "You don't have permission to do that", flash[:notice]
  end

  test "should get edit" do
    # ST can edit all characters
    login_as(users(:Storyteller))

    get :edit, :id => characters(:one).to_param
    assert_response :success

    # can edit own characters
    login_as(users(:two))

    get :edit, :id => characters(:two).to_param
    assert_response :success
  end

  test "shouldn't get edit" do
    # not logged in
    get :edit, :id => characters(:one).to_param

    assert_redirected_to :controller => "admin", :action => "login"
    assert_equal "Please log in", flash[:notice]

    # can't edit other users' characters
    login_as(users(:one))

    get :edit, :id => characters(:two).to_param

    assert_redirected_to character_path(characters(:two))
    assert_equal "You don't have permission to do that", flash[:notice]
  end

  test "should update character" do
    put :update, :id => characters(:one).to_param, :character => { }
    assert_redirected_to character_path(assigns(:character))
  end

  test "should destroy character" do
    assert_difference('Character.count', -1) do
      delete :destroy, :id => characters(:one).to_param
    end

    assert_redirected_to characters_path
  end
end
