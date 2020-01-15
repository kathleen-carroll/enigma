require_relative 'test_helper'
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
    key = Key.new("73659")
    shift2 = Shift.new(key, @offset1)
    assert_equal 73+4, shift2.a
    assert_equal 36+4, shift2.b
    assert_equal 65+0, shift2.c
    assert_equal 59+0, shift2.d
  end

  def test_it_can_find_shift_values_with_diff_offset
    key = Key.new("73659")
    offset = Offset.new("250894")
    shift2 = Shift.new(key, offset)
    assert_equal 73+9, shift2.a
    assert_equal 36+2, shift2.b
    assert_equal 65+3, shift2.c
    assert_equal 59+6, shift2.d
  end

  def test_character_array_and_position_hash
    assert_equal 27, @shift.characters.length
    assert_equal " ", @shift.character_position["27"]
    assert_equal "d", @shift.character_position["4"]
  end
end
