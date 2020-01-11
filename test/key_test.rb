require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'

class KeyTest < Minitest::Test
  def setup
    @key1 = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key1
  end

  def test_it_generates_new_key
    assert_equal 5, @key1.value.digits.length
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
end
