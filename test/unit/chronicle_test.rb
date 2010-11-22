require 'test_helper'

class ChronicleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "shouldn't save without a name" do
    c = Chronicle.new
    assert(!c.save, "Saved without a name.")
  end
  
  test "shouldn't save with a non-unique name" do
    Chronicle.create(:name => "unique")
    c = Chronicle.new(:name => "unique")
    
    assert(!c.save, "Saved with a non-unique name")
  end
end
