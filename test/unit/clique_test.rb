require 'test_helper'

class CliqueTest < ActiveSupport::TestCase
  test "shouldn't save without a name" do
    c = Clique.new

    assert !c.save, "saved without a name"
  end

  test "shouldn't save with a non-unique name" do
    Clique.create(:name => "unique")
    c = Clique.new(:name => "unique")

    assert !c.save, "saved with a non-unique name"
  end
end
