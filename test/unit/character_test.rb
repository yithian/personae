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
end
