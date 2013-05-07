require 'test_helper'

class SplatTest < ActiveSupport::TestCase
  test "shouldn't save without a name" do
    s = Splat.new(:nature_name => "nature", :clique_name => "clique", :ideology_name => "ideology", :integrity_name => "integrity", :power_stat_name => "power stat", :fuel_name => "fuel")

    assert !s.save, "saved splat without a name"
  end

  test "shouldn't save with a non-unique name" do
    Splat.create(:name => "unique", :nature_name => "nature", :clique_name => "clique", :ideology_name => "ideology", :integrity_name => "integrity", :power_stat_name => "power stat", :fuel_name => "fuel")
    s = Splat.new(:name => "unique", :nature_name => "nature", :clique_name => "clique", :ideology_name => "ideology", :integrity_name => "integrity", :power_stat_name => "power stat", :fuel_name => "fuel")

    assert !s.save, "saved with a non-unique name"
  end

  test "shouldn't save without a nature name" do
    s = Splat.new(:name => "nature_test", :clique_name => "clique", :ideology_name => "ideology", :integrity_name => "integrity", :power_stat_name => "power stat", :fuel_name => "fuel")

    assert !s.save, "saved without a nature name"
  end

  test "shouldn't save without a clique name" do
    s = Splat.new(:name => "clique_test", :nature_name => "nature", :ideology_name => "ideology", :integrity_name => "integrity", :power_stat_name => "power stat", :fuel_name => "fuel")

    assert !s.save, "saved without a clique name"
  end

  test "shouldn't save without an ideology name" do
    s = Splat.new(:name => "ideology_test", :nature_name => "nature", :clique_name => "clique", :integrity_name => "integrity", :power_stat_name => "power stat", :fuel_name => "fuel")

    assert !s.save, "saved without an ideology name"
  end

  test "shouldn't save without a integrity name" do
    s = Splat.new(:name => "integrity_test", :nature_name => "nature", :clique_name => "clique", :ideology_name => "ideology", :power_stat_name => "power stat", :fuel_name => "fuel")

    assert !s.save, "saved without a integrity name"
  end

  test "shouldn't save without a power stat name" do
    s = Splat.new(:name => "power_stat_test", :nature_name => "nature", :clique_name => "clique", :ideology_name => "ideology", :integrity_name => "integrity", :fuel_name => "fuel")

    assert !s.save, "saved without a power stat name"
  end

  test "shouldn't save without a fuel name" do
    s = Splat.new(:name => "power_stat_test", :nature_name => "nature", :clique_name => "clique", :ideology_name => "ideology", :integrity_name => "integrity", :power_stat_name => "power stat")

    assert !s.save, "saved without a fuel stat name"
  end
end
