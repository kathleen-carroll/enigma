require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/offset'

class OffsetTest < Minitest::Test
  def setup
    @offset1 = Offset.new
    @offset2 = Offset.new("250894")
  end

  def test_it_exists
    assert_instance_of Offset, @offset1
  end

  def test_it_has_attributes
    assert_equal "130120", @offset1.date
    assert_equal "4400", @offset1.get_date_code
    assert_equal "250894", @offset2.date
    assert_equal "9236", @offset2.get_date_code
  end

  def test_it_can_find_offset_groups
    assert_equal "4", @offset1.a
    assert_equal "4", @offset1.b
    assert_equal "0", @offset1.c
    assert_equal "0", @offset1.d
  end
end
