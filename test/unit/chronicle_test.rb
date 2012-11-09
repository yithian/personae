require 'test_helper'

class ChronicleTest < ActiveSupport::TestCase
  test "shouldn't save without a name" do
    c = Chronicle.new
    assert(!c.save, "Saved without a name.")
  end
  
  test "shouldn't save with a non-unique name" do
    Chronicle.create(:name => "unique")
    c = Chronicle.new(:name => "unique")
    
    assert(!c.save, "Saved with a non-unique name")
  end

  test "should return paginated npcs to storyteller" do
    c = chronicles(:two)
    npcs = c.find_npcs(users(:Storyteller), 1)

    assert(npcs.include?(characters(:two)), "character not included in npcs")
  end

  test "should return paginated npcs to player" do
    c = chronicles(:two)
    npcs = c.find_npcs(users(:three), 1)

    refute(npcs.include?(characters(:two)), "hidden character included in npcs")
  end
end
