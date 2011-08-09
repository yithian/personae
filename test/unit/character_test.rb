require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test "shouldn't save without name" do
    c = Character.new(:clique_id => 1, :virtue => "Charity", :vice => "Envy")
    
    assert(!c.save, "saved without a name")
  end
  
  test "shouldn't save with a non-unique name" do
    Character.create(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Envy")
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Envy")
    
    assert(!c.save, "saved with a non-unique name")
  end

  test "shouldn't save with an invalid virtue" do
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Beauty", :vice => "Envy")

    assert(!c.save, "saved with an invalid virtue")
  end

  test "shouldn't save with an invalid vice" do
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Vanity")

    assert(!c.save, "saved with an invalid vice")
  end
  
  test "should save multiple vices" do
    c = Character.new(:name => "Unique", :concept => "just a guy", :clique_id => 1, :virtue => "Charity", :vice => "Envy Greed")
    
    assert(c.save, "didn't validate multiple vices")
    assert_equal(Character.find_by_name("Unique").vice, "Envy Greed")
  end
  
  test "shouldn't save with too many vices" do
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Envy Greed Lust")
    
    assert(!c.save, "validated with too many vices")
  end
end
