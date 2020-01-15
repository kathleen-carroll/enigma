require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/key'

class KeyTest < Minitest::Test
  def setup
    @key1 = Key.new
    @key2 = Key.new("23435")
  end

  def test_it_exists
    assert_instance_of Key, @key1
    assert_instance_of Key, @key2
  end

  def test_it_generates_new_key
    key = mock("23770")
    assert_equal 5, @key1.value.length
    assert_equal "23435", @key2.value
    
    @key1.stub(:key_generator, "23770") do
      assert_equal "23770", @key1.key_generator
    end
  end

  def test_it_can_find_2_digit_groups
    assert_equal 2, @key1.a.length
    assert_equal @key1.value.to_s[0..1], @key1.a
    assert_equal 2, @key1.b.length
    assert_equal @key1.value.to_s[1..2], @key1.b
    assert_equal 2, @key1.c.length
    assert_equal @key1.value.to_s[2..3], @key1.c
    assert_equal 2, @key1.d.length
    assert_equal @key1.value.to_s[3..4], @key1.d
  end

  def test_it_can_find_more_groups
    assert_equal "23", @key2.a
    assert_equal "34", @key2.b
    assert_equal "43", @key2.c
    assert_equal "35", @key2.d
  end
end
