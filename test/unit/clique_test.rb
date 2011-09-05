require 'test_helper'

class CliqueTest < ActiveSupport::TestCase
  test "shouldn't save without a name" do
    c = Clique.new(:chronicle_id => chronicles(:two).id)

    assert !c.save, "saved without a name"
  end

  test "shouldn't save with a non-unique name" do
    Clique.create(:name => "unique", :chronicle_id => chronicles(:two).id)
    c = Clique.new(:name => "unique", :chronicle_id => chronicles(:two).id)

    assert !c.save, "saved with a non-unique name"
  end

  test "should save with a non-unique name" do
    c = Clique.new(:name => "MyCliqueName", :chronicle_id => chronicles(:two).id)

    assert(c.save, "did not save with a non-unique name in different chronicles")
  end
end
