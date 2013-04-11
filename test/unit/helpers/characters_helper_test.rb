# coding: utf-8
require 'test_helper'

class CharactersHelperTest < ActionView::TestCase
  test "dot_format should return dots" do
    assert_equal dot_format(2), "••"
  end
  test "dot_format should insert a space after each 5 dots" do
    assert_equal dot_format(11),  "••••• ••••• •"
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
end
