require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test "shouldn't save without name" do
    c = Character.new(:clique_id => 1, :virtue => "Charity", :vice => "Envy", :chronicle_id => chronicles(:two).id)
    
    assert(!c.save, "saved without a name")
  end
  
  test "shouldn't save with a non-unique name" do
    Character.create(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Envy", :chronicle_id => chronicles(:one).id)
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Envy", :chronicle_id => chronicles(:one).id)
    
    assert(!c.save, "saved with a non-unique name")
  end
  
  test "should save with a non-unique name" do
    c = Character.new(:name => "MyName", :clique_id => 1, :virtue => "Charity", :vice => "Envy", :chronicle_id => chronicles(:two).id)
    
    assert(c.save, "did not save with a non-unique name in different chronicles")
  end

  test "shouldn't save with an invalid virtue" do
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Beauty", :vice => "Envy", :chronicle_id => chronicles(:one).id)

    assert(!c.save, "saved with an invalid virtue")
  end

  test "shouldn't save with an invalid vice" do
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Vanity", :chronicle_id => chronicles(:one).id)

    assert(!c.save, "saved with an invalid vice")
  end
  
  test "should save multiple vices" do
    c = Character.new(:name => "Unique", :concept => "just a guy", :clique_id => 1, :virtue => "Charity", :vice => "Envy Greed", :chronicle_id => chronicles(:one).id)
    
    assert(c.save, "didn't validate multiple vices")
    assert_equal(Character.find_by_name("Unique").vice, "Envy Greed")
  end
  
  test "shouldn't save with too many vices" do
    c = Character.new(:name => "Unique", :clique_id => 1, :virtue => "Charity", :vice => "Envy Greed Lust", :chronicle_id => chronicles(:one).id)
    
    assert(!c.save, "validated with too many vices")
  end
end
