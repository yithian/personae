require 'test_helper'

class CliquesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def assert_login
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end

  def assert_denied
    assert_redirected_to root_path
    assert_equal "Access denied!", flash[:error]
  end

  def assert_show_view
    assert_select "h5", :minimum => 2

    assert_template "member"
    
    get :show, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    assert_select "h5", :content => /Totem/
  end
  
  test "should get index when logged out" do
    get :index, :chronicle_id => Chronicle.first
    assert_response :success
    assert_not_nil assigns(:cliques)
  end
  
  test "should get index when logged in" do
    sign_in(users(:one))
    
    get :index, :chronicle_id => Chronicle.find(users(:one).selected_chronicle_id)
    assert_response :success
    assert_not_nil assigns(:cliques)
  end

  test "should get new" do
    sign_in(users(:one))
    
    get :new, :chronicle_id => chronicles(:one).id
    assert_response :success
    assert_not_nil assigns(:clique)
  end

  test "shouldn't get new" do
    get :new, :chronicle_id => chronicles(:one)
    assert_login
  end

  test "should create clique" do
    sign_in(users(:one))
    
    assert_difference('Clique.count') do
      post :create, :clique => { :name => "unique", :chronicle_id => chronicles(:one).id }, :chronicle_id => chronicles(:one)
    end

    assert_redirected_to chronicle_clique_path(Clique.last.chronicle, Clique.last)
    assert_not_nil assigns(:clique)
    assert_equal "Clique was successfully created.", flash[:notice], "clique wasn't updated"
  end

  test "shouldn't create clique" do
    assert_no_difference('Clique.count') do
      post :create, :clique => { :name => "unique", :chronicle_id => chronicles(:one).id }, :chronicle_id => cliques(:one).chronicle
    end

    assert_login
  end

  test "should show clique as nobody" do
    # not logged in
    get :show, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @response.body
    assert_not_nil assigns(:clique)
    assert_show_view
  end

  test "should show clique as ST" do
    # ST sees all cliques
    sign_in(users(:Storyteller))
    
    get :show, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @response
    assert_not_nil assigns(:clique)
    get :show, :id => cliques(:two).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @response
    assert_not_nil assigns(:clique)

    assert_show_view
  end

  test "should show clique as admin" do
    # so does user who owns chronicle
    sign_in(users(:two))
    
    get :show, :id => cliques(:three).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @response
    assert_not_nil assigns(:clique)
  end

  test "should show clique as member" do
    # show clique as member
    sign_in(users(:one))

    get :show, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @response
    assert_not_nil assigns(:clique)

    assert_show_view
  end

  test "should show clique as other user" do
    # show known clique as other user
    sign_in(users(:two))

    get :show, :id => cliques(:two).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @repsonse
    assert_not_nil assigns(:clique)

    assert_show_view
  end

  test "shouldn't show clique" do
    sign_in(users(:one))
    
    # clique two has write set to false
    get :show, :id => cliques(:three).to_param, :chronicle_id => cliques(:three).chronicle
    assert_redirected_to chronicle_cliques_path(cliques(:three).chronicle)
    assert_equal "Access denied!", flash[:error], "showed unknown clique when logged in"
  end

  test "should get edit" do
    sign_in(users(:Storyteller))
    
    get :edit, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @response

    # owning user
    sign_in(users(:one))

    get :edit, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    assert_response :success, @response
    
    # user owns chronicle
    sign_in(users(:two))

    get :edit, :id => cliques(:three).to_param, :chronicle_id => cliques(:three).chronicle
    assert_response :success, @response
  end

  test "shouldn't get edit as nobody" do
    # not logged in
    get :edit, :id => cliques(:two).to_param, :chronicle_id => cliques(:two).chronicle
    assert_login
  end

  test "shouldn't get edit on other users' cliques" do
    # non-owning user
    sign_in(users(:one))
    
    get :edit, :id => cliques(:two).to_param, :chronicle_id => cliques(:two).chronicle
    assert_redirected_to chronicle_clique_path(cliques(:two).chronicle, cliques(:two))
    assert_equal "Access denied!", flash[:error], "got edit as non-owning user"
  end

  test "shouldn't get edit for static clique" do
    # no one should be able to edit the Solitary clique
    sign_in(users(:Storyteller))
    
    get :edit, :id => cliques(:Solitary).to_param, :chronicle_id => cliques(:two).chronicle
    assert_redirected_to chronicle_clique_path(cliques(:one).chronicle, cliques(:Solitary))
    assert_equal "Access denied!", flash[:error], "got edit for static clique"

    sign_in(users(:one))
    
    get :edit, :id => cliques(:Solitary).to_param, :chronicle_id => cliques(:two).chronicle
    assert_redirected_to chronicle_clique_path(cliques(:one).chronicle, cliques(:Solitary))
    assert_equal "Access denied!", flash[:error], "got edit for static clique"
  end

  test "shouldn't put update for static clique" do
    # no one should be able to edit the Solitary clique
    sign_in(users(:Storyteller))
    
    put :update, :id => cliques(:Solitary).to_param, :chronicle_id => cliques(:one).chronicle
    assert_redirected_to chronicle_clique_path(chronicles(:one), cliques(:Solitary))
    assert_equal "Access denied!", flash[:error], "got edit for static clique"

    sign_in(users(:one))
    
    put :update, :id => cliques(:Solitary).to_param, :chronicle_id => chronicles(:one)
    assert_redirected_to chronicle_clique_path(chronicles(:one), cliques(:Solitary))
    assert_equal "Access denied!", flash[:error], "got edit for static clique"
  end

  test "shouldn't destroy static clique" do
    # no one should be able to edit the Solitary clique
    sign_in(users(:Storyteller))

    assert_no_difference('Clique.count', "destroyed static clique") do
      delete :destroy, :id => cliques(:Solitary).to_param, :chronicle_id => cliques(:Solitary).chronicle
    end

    assert_redirected_to chronicle_clique_path(cliques(:Solitary).chronicle, cliques(:Solitary))
    assert_equal("Access denied!", flash[:error])
  end

  test "should update clique" do
    # ST can update all
    sign_in(users(:Storyteller))
    
    put :update, :id => cliques(:one).to_param, :clique => { }, :chronicle_id => cliques(:one).chronicle
    assert_redirected_to chronicle_clique_path(assigns(:clique).chronicle, assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "clique wasn't updated as ST"
    
    # update clique in owned chronicle
    sign_in(users(:two))
    
    put :update, :id => cliques(:three).to_param, :clique => { }, :chronicle_id => cliques(:three).chronicle
    assert_redirected_to chronicle_clique_path(assigns(:clique).chronicle, assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "clique wasn't updated as user who owns chronicle"
    
    # update owned clique
    sign_in(users(:one))

    put :update, :id => cliques(:one).to_param, :clique => { }, :chronicle_id => cliques(:one).chronicle
    assert_redirected_to chronicle_clique_path(assigns(:clique).chronicle, assigns(:clique))
    assert_equal "Clique was successfully updated.", flash[:notice], "clique wasn't updated as owner"
  end

  test "shouldn't update clique as nobody" do
    # shouldn't update when not logged in
    put :update, :id => cliques(:one).to_param, :clique => { }, :chronicle_id => cliques(:one).chronicle
    assert_login
  end

  test "shouldn't update other users' cliques" do
    # shouldn't update as non-owning user
    sign_in(users(:one))
    
    put :update, :id => cliques(:two).to_param, :clique => { }, :chronicle_id => cliques(:one).chronicle
    assert_redirected_to chronicle_clique_path(cliques(:two).chronicle, cliques(:two))
    assert_equal "Access denied!", flash[:error], "clique was updated"
  end

  test "should destroy clique" do
    # ST can destroy all
    sign_in(users(:Storyteller))
    
    assert_difference('Clique.count', -1, "ST couldn't destroy clique") do
      delete :destroy, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    end
    assert_redirected_to chronicle_cliques_path(cliques(:one).chronicle)
    
    # user who owns chronicle can destroy any inside said chronicle
    sign_in(users(:two))

    assert_difference('Clique.count', -1, "user who owns chronicle couldn't destroy clique") do
      delete :destroy, :id => cliques(:three).to_param, :chronicle_id => cliques(:three).chronicle
    end
    assert_redirected_to chronicle_cliques_path(cliques(:three).chronicle)

    # destroy clique as owner
    sign_in(users(:two))
    
    assert_difference('Clique.count', -1, "owning user couldn't destroy clique") do
      delete :destroy, :id => cliques(:two).to_param, :chronicle_id => cliques(:two).chronicle
    end
    assert_redirected_to chronicle_cliques_path(cliques(:two).chronicle)
  end

  test "shouldn't destroy clique as nobody" do
    # shouldn't destroy when not logged in
    assert_no_difference('Clique.count', "destroyed when not logged in") do
      delete :destroy, :id => cliques(:one).to_param, :chronicle_id => cliques(:one).chronicle
    end

    assert_login
  end

  test "shouldn't destroy other users' cliques" do
    # shouldn't destroy as non-owning user
    sign_in(users(:three))
    
    assert_no_difference('Clique.count', "destroyed as non-owning user") do
      delete :destroy, :id => cliques(:two).to_param, :chronicle_id => cliques(:two).chronicle
    end

    assert_redirected_to chronicle_clique_path(cliques(:two).chronicle, cliques(:two))
    assert_equal("Access denied!", flash[:error])
  end
  
  test "should update members' chronicles" do
    sign_in(users(:Storyteller))
    
    put :update, :id => cliques(:one).to_param, :clique => {:chronicle_id => chronicles(:two).id}, :chronicle_id => cliques(:one).chronicle
    
    assert_equal(chronicles(:two), Character.find_by_id(characters(:one).id).chronicle, "updating clique's chronicle didn't update it's characters'")
    
    # owning non-Storyteller user
    sign_in(users(:two))

    put :update, :id => cliques(:two).to_param, :clique => {:chronicle_id => chronicles(:three).id}, :chronicle_id => cliques(:one).chronicle

    assert_equal(chronicles(:three), Character.find_by_id(characters(:two).id).chronicle, "updating clique's chronicle didn't update it's characters'")
  end
  
  test "shouldn't update members' chronicles" do
    # not logged in
    put :update, :id => cliques(:one).to_param, :clique => {:chronicle_id => chronicles(:two).id}, :chronicle_id => cliques(:one).chronicle
    
    assert_not_equal(chronicles(:two), Character.find_by_id(characters(:one).id).chronicle, "updating clique's chronicle updated it's characters' when not logged in")
    
    # non-owning non-Storyteller user
    sign_in(users(:one))

    put :update, :id => cliques(:two).to_param, :clique => {:chronicle_id => chronicles(:three).id}, :chronicle_id => cliques(:one).chronicle

    assert_not_equal(chronicles(:three), Character.find_by_id(characters(:two).id).chronicle, "updating clique's chronicle didn't update it's characters'")
  end
end
