require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "shouldn't save without a name" do
    u = User.new(:password => "pword")

    assert !u.save, "saved without a name"
  end

  test "shouldn't save with a non-unique name" do
    User.create(:name => "unique", :password => "pword")
    u = User.new(:name => "unique", :password => "pword")

    assert !u.save, "saved with a non-unique name"
  end

  test "shouldn't save without a password" do
    u = User.new(:name => "name_test")

    assert !u.save, "saved without a password"
  end

  test "password read" do
    u = User.create(:name => "unique", :password => "pword")

    assert_equal "pword", u.password, "password didn't read properly"
  end

  test "password set" do
    u = User.create(:name => "unique", :password => "pword")
    u.password = "password"
    u.save
    
    assert_equal "password", u.password, "password didn't write properly"
  end
  
  test "successfully authenticate user" do
    User.create(:name => "unique", :password => "pword")
    u = User.authenticate("unique", "pword")

    assert_not_nil u, "user didn't successfully authenticate"
  end
  
  test "unsuccessfully authenticate user" do
    User.create(:name => "unique", :password => "pword")
    u = User.authenticate("unique", "not_pword")

    assert_nil u, "user somehow authenticated"
  end
  
  test "shouldn't destroy last user" do
    assert_raise RuntimeError do
      User.find(:all).each do |user|
        user.destroy
      end
    end
  end
  
  test "shouldn't destroy storyteller user" do
    User.create(:name => "Storyteller", :password => "pword")
    
    assert_raise RuntimeError do
      User.find_by_name("Storyteller").destroy
    end
  end
end
