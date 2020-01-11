require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/shift'
require './lib/offset'
require './lib/key'

class ShiftTest < Minitest::Test
  def setup
    @offset1 = Offset.new
    @key1 = Key.new
    @shift = Shift.new(@key1, @offset1)
  end

  def test_it_exists
    assert_instance_of Shift, @shift
  end

  def test_it_can_find_shift_values
    key = Key.new
    key.value = 73659
    shift2 = Shift.new(key, @offset1)
    #offset = 4400
    assert_equal 73+4, shift2.a
    assert_equal 36+4, shift2.b
    assert_equal 65+0, shift2.c
    assert_equal 59+0, shift2.d
  end
end
