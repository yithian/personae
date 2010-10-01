require 'test_helper'

class IdeologyTest < ActiveSupport::TestCase
  test "shouldn't save without a name" do
    n = Nature.new
    
    assert !n.save, "saved without a name"
  end

  test "shouldn't save with a non-unique name" do
    Nature.create(:name => "unique")
    n = Nature.new(:name => "unique")

    assert !n.save, "saved with a non-unique name"
  end
end
