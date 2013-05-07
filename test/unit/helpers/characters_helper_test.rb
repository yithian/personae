# coding: utf-8
require 'test_helper'

class CharactersHelperTest < ActionView::TestCase
  test "dot_format should return dots" do
    assert_equal dot_format(2), "••"
  end
  test "dot_format should insert a space after each 5 dots" do
    assert_equal dot_format(11),  "••••• ••••• •"
  end

  test "clickable_specialties should not change normal text" do
    assert_equal clickable_specialties("foo"), "foo"
    assert_equal clickable_specialties("745"), "745"
    assert_equal clickable_specialties("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer placerat blandit nunc a fringilla. Aenean ante arcu, sollicitudin non ullamcorper quis, feugiat at odio. Etiam scelerisque nibh tristique tortor tempor fermentum. Nullam ac magna quis orci rhoncus luctus. In tristique orci nec nulla iaculis auctor. Duis in sapien eu nulla semper aliquam eu nec nibh. Maecenas posuere libero eget eros euismod a blandit sem molestie. Cras eget iaculis ipsum. Nam erat justo, placerat ut aliquet et, malesuada ac mauris. Donec tortor mauris, dictum id sollicitudin vel, sodales eget metus. Proin fringilla ipsum nec nibh lacinia sed aliquet velit fringilla"), "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer placerat blandit nunc a fringilla. Aenean ante arcu, sollicitudin non ullamcorper quis, feugiat at odio. Etiam scelerisque nibh tristique tortor tempor fermentum. Nullam ac magna quis orci rhoncus luctus. In tristique orci nec nulla iaculis auctor. Duis in sapien eu nulla semper aliquam eu nec nibh. Maecenas posuere libero eget eros euismod a blandit sem molestie. Cras eget iaculis ipsum. Nam erat justo, placerat ut aliquet et, malesuada ac mauris. Donec tortor mauris, dictum id sollicitudin vel, sodales eget metus. Proin fringilla ipsum nec nibh lacinia sed aliquet velit fringilla"
    assert_equal clickable_specialties("Subterfuge (White Lies)"), "Subterfuge (White Lies)"
  end
  test "clickable_specialties should change specialties" do
    string = "[:subterfuge: (White Lies)]"
    assert_not_equal clickable_specialties(string), string
  end
  test "clickable_specialties should return a custom_stats div class" do
    string = "[:subterfuge: (White Lies)]"
    assert_match(/div class='custom_stats'/, clickable_specialties(string))
  end
  test "clickable_specialties should return a dots_label li" do
    string = "[:subterfuge: (White Lies)]"
    assert_match(/li class='dots_label'/, clickable_specialties(string))
  end
  test "clickable_specialties should return an id'ed li" do
    string = "[:subterfuge: (White Lies)]"
    assert_match(/li id='.*'/, clickable_specialties(string))
  end
  test "clickable_specialties should return a dots_number li" do
    string = "[:subterfuge: (White Lies)]"
    assert_match(/li[^<^>]*class='[^']*dots_number'/, clickable_specialties(string))
  end

  test "clickable_stats should not change normal text" do
    assert_equal clickable_stats("foo"), "foo"
    assert_equal clickable_stats("745"), "745"
    assert_equal clickable_stats("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer placerat blandit nunc a fringilla. Aenean ante arcu, sollicitudin non ullamcorper quis, feugiat at odio. Etiam scelerisque nibh tristique tortor tempor fermentum. Nullam ac magna quis orci rhoncus luctus. In tristique orci nec nulla iaculis auctor. Duis in sapien eu nulla semper aliquam eu nec nibh. Maecenas posuere libero eget eros euismod a blandit sem molestie. Cras eget iaculis ipsum. Nam erat justo, placerat ut aliquet et, malesuada ac mauris. Donec tortor mauris, dictum id sollicitudin vel, sodales eget metus. Proin fringilla ipsum nec nibh lacinia sed aliquet velit fringilla"), "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer placerat blandit nunc a fringilla. Aenean ante arcu, sollicitudin non ullamcorper quis, feugiat at odio. Etiam scelerisque nibh tristique tortor tempor fermentum. Nullam ac magna quis orci rhoncus luctus. In tristique orci nec nulla iaculis auctor. Duis in sapien eu nulla semper aliquam eu nec nibh. Maecenas posuere libero eget eros euismod a blandit sem molestie. Cras eget iaculis ipsum. Nam erat justo, placerat ut aliquet et, malesuada ac mauris. Donec tortor mauris, dictum id sollicitudin vel, sodales eget metus. Proin fringilla ipsum nec nibh lacinia sed aliquet velit fringilla"
    assert_equal clickable_stats("Resources: 5"), "Resources: 5"
  end
  test "clickable_stats should change stats" do
    assert_not_equal clickable_stats('[:resources: *3*]'), '[:resources: *3*]'
  end
  test "clickable_stats should change stats with a description" do
    assert_not_equal clickable_stats('[:resources: *3* (foo, bar-baz)]'), '[:resources: *3* (foo, bar-baz)]'
  end
  test "clickable_stats should return a custom_stats div class" do
    assert_match(/div class='custom_stats'/, clickable_stats('[:resources: *3*]'))
  end
  test "clickable_stats should return a dots_label li" do
    assert_match(/li class='dots_label'/, clickable_stats('[:resources: *3*]'))
  end
  test "clickable_stats should return an id'ed li" do
    assert_match(/li id='.*'/, clickable_stats('[:resources: *3*]'))
  end
  test "clickable_stats should return a dots_number li" do
    assert_match(/li[^<^>]*class='dots_number'/, clickable_stats('[:resources: *3*]'))
  end
  test "clickable_stats should not return a dots_description if no description is provided" do
    assert_no_match(/li class='dots_description'/, clickable_stats('[:resources: *3*]'))
  end
  test "clickable_stats should return a dots_description if a description is provided" do
    assert_match(/li class='dots_description'/, clickable_stats('[:resources: *3* (fooybar)]'))
  end

  test "make_rollable should not change normal text" do
    assert_equal make_rollable("foo"), "foo"
    assert_equal make_rollable("745"), "745"
    assert_equal make_rollable("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer placerat blandit nunc a fringilla. Aenean ante arcu, sollicitudin non ullamcorper quis, feugiat at odio. Etiam scelerisque nibh tristique tortor tempor fermentum. Nullam ac magna quis orci rhoncus luctus. In tristique orci nec nulla iaculis auctor. Duis in sapien eu nulla semper aliquam eu nec nibh. Maecenas posuere libero eget eros euismod a blandit sem molestie. Cras eget iaculis ipsum. Nam erat justo, placerat ut aliquet et, malesuada ac mauris. Donec tortor mauris, dictum id sollicitudin vel, sodales eget metus. Proin fringilla ipsum nec nibh lacinia sed aliquet velit fringilla"), "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer placerat blandit nunc a fringilla. Aenean ante arcu, sollicitudin non ullamcorper quis, feugiat at odio. Etiam scelerisque nibh tristique tortor tempor fermentum. Nullam ac magna quis orci rhoncus luctus. In tristique orci nec nulla iaculis auctor. Duis in sapien eu nulla semper aliquam eu nec nibh. Maecenas posuere libero eget eros euismod a blandit sem molestie. Cras eget iaculis ipsum. Nam erat justo, placerat ut aliquet et, malesuada ac mauris. Donec tortor mauris, dictum id sollicitudin vel, sodales eget metus. Proin fringilla ipsum nec nibh lacinia sed aliquet velit fringilla"
    assert_equal make_rollable("Strength + Brawl"), "Strength + Brawl"
  end
  test "make_rollable should match a single stat" do
    string = "[:foo: Strength]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match two stats" do
    string = "[:foo: Strength + Brawl]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match three stats" do
    string = "[:foo: Strength + Brawl]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match a single number" do
    string = "[:foo: Strength + Brawl + Gnosis]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match a single number and a stat" do
    string = "[:foo: 5 + Wits]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match a single stat and a number" do
    string = "[:foo: Intelligence + 3]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match 9 again" do
    string = "[:foo: Strength + Brawl *9-again*]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should  match 8 again" do
    string = "[:foo: Strength + Brawl *8-again*]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match rote" do
    string = "[:foo: Strength + Brawl *rote*]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match 1s cancel" do
    string = "[:foo: Strength + Brawl *1s-cancel*]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should match multiple modifiers" do
    string = "[:foo: Strength + Brawl *1s-cancel,rote*]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should subtract a number" do
    string = "[:foo: Wits - 3]"
    assert_not_equal make_rollable(string), string
  end
  test "make_rollable should include a rollable class div" do
    string = "[:foo: Strength + Brawl]"
    assert_match(/div class='rollable'/, make_rollable(string))
  end
  test "make_rollable should include a rollable class span" do
    string = "[:foo: Strength + Brawl]"
    assert_match(/span class='rollable'/, make_rollable(string))
  end
  test "make_rollable should include a roll_stats ul"  do
    string = "[:foo: Strength + Brawl]"
    assert_match(/ul class='roll_stats'/, make_rollable(string))
  end

  integrity = {'mortal' => 'integrity', 'mage' => 'wisdom', 'werewolf' => 'harmony', 'vampire' => 'humanity', 'promethean' => 'humanity', 'changeling' => 'clarity', 'hunter' => 'integrity', 'geist' => 'synergy', 'spirit' => 'integrity', 'mummy' => 'memory'}
  power_stat = {'mage' => 'gnosis', 'werewolf' => 'primal_urge', 'vampire' => 'blood_potency', 'promethean' => 'azoth', 'changeling' => 'wyrd', 'geist' => 'psyche', 'spirit' => 'rank', 'mummy' => 'sekhem'}
  %w(mortal mage werewolf vampire promethean changeling hunter geist spirit mummy).each do |splat|
    test "generalize_stat_name should work for #{splat}" do
      assert_equal 'Integrity', generalize_stat_name(integrity[splat])
      assert_equal 'Power_Stat', generalize_stat_name(power_stat[splat]) if power_stat.has_key?(splat)
    end
  end


end
