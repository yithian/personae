require 'test_helper'

class CommentsTest < ActiveSupport::TestCase
  test "shouldn't save without body" do
    c = Comment.new(:user_id => 1, :character_id => 1)
    
    assert !c.save, "saved without body text"
  end
  
  test "shouldn't save without user_id" do
    c = Comment.new(:body => "BodyText", :character_id => 1)
    
    assert(!c.save, "saved without user_id")
  end
  
  test "shouldn't save without character_id" do
    c = Comment.new(:body => "BodyText", :user_id => 1)
    
    assert(!c.save, "saved without character_id")
  end
end
