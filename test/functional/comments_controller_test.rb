require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test 'should get new' do
    sign_in(users(:one))

    get :new, params: {character_id: characters(:one).id, user: users(:one), chronicle_id: characters(:one).chronicle}
    assert_response :success, @response.message
  end
  
  test 'shouldn\'t get new as nobody' do
    # when not logged in
    get :new, params: {character_id: characters(:one).id, chronicle_id: characters(:one).chronicle}
    assert_redirected_to new_user_session_path
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end

  test 'shouldn\'t get new on hidden character' do
    sign_in(users(:one))

    # character two isn't visible
    get :new, params: {character_id: characters(:two).id, chronicle_id: characters(:one).chronicle}
    assert_redirected_to chronicle_characters_path(Chronicle.find(users(:one).selected_chronicle_id))
  end
  
  test 'should create comment' do
    sign_in(users(:one))

    assert_difference('Comment.count', 1, message: 'didn\'t create comment') do
      post :create, params: {character_id: characters(:one).id, comment: { character_id: characters(:one).id, user_id: users(:one).id, speaker: characters(:one).name, body: 'some words' }, chronicle_id: characters(:one).chronicle}
    end
    assert_redirected_to chronicle_character_path(characters(:one).chronicle, characters(:one))
  end

  test 'shouldn\'t create comment as nobody' do
    # not logged in
    assert_no_difference('Comment.count', 'got past authentication') do
      post :create, params: {character_id: characters(:one).id, comment: { character_id: characters(:one).id, user_id: users(:one).id, speaker: characters(:one).name, body: 'some words' }, chronicle_id: characters(:one).chronicle}
    end
    assert_redirected_to new_user_session_path
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end

  test 'shouldn\'t create comment on hidden character' do
    # character two isn't visible
    sign_in(users(:one))

    assert_no_difference('Comment.count', 'commented on character that shouldn\'t be visible') do
      post :create, params: {character_id: characters(:two).id, comment: { character_id: characters(:two).id, user_id: users(:one).id, speaker: characters(:one).name, body: 'some words' }, chronicle_id: characters(:one).chronicle}
    end
    assert_redirected_to chronicle_characters_path(Chronicle.find(users(:one).selected_chronicle_id))
  end

  test 'should destroy comment' do
    # ST can remove all comments
    sign_in(users(:Storyteller))
    
    assert_difference('Comment.count', -1, 'ST didn\'t destroy comment') do
      delete :destroy, params: {id: comments(:one).id, character_id: characters(:one).id, chronicle_id: characters(:one).chronicle}
    end
    assert_redirected_to chronicle_character_path(characters(:one).chronicle, characters(:one))

    # destroy own comments
    sign_in(users(:two))
    
    assert_difference('Comment.count', -1, 'user didn\'t destroy own comment') do
      delete :destroy, params: {id: comments(:two).id, character_id: characters(:two).id, chronicle_id: characters(:one).chronicle}
    end
    assert_redirected_to chronicle_character_path(characters(:two).chronicle, characters(:two))
  end

  test 'shouldn\'t destroy comment as nobody' do
    # logged out
    assert_no_difference('Comment.count', 'got past authentication') do
      delete :destroy, params: {id: comments(:one).id, character_id: characters(:one).id, chronicle_id: characters(:one).chronicle}
    end
    assert_redirected_to new_user_session_path
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end

  test 'shouldn\'t destroy other users\' comments' do
    # destroy other user's comment
    sign_in(users(:two))

    assert_no_difference('Comment.count', 'deleted other user\'s comment') do
      delete :destroy, params: {id: comments(:one).id, character_id: characters(:one).id, chronicle_id: characters(:one).chronicle}
    end
    assert_redirected_to chronicle_character_path(characters(:one).chronicle, characters(:one))
    assert_equal 'Access denied!', flash[:error]
  end
end
