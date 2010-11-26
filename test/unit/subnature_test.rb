require 'test_helper'

class SubnatureTest < ActiveSupport::TestCase
  test "shouldn't save without a name" do
    s = Subnature.new
    assert(!s.save, "saved subnature without a name")
  end
  
  test "shouldn't save with a non-unique name" do
    s = Subnature.new(:name => "MyName")
    assert(!s.save, "saved with a non-unique name")
  end
end
