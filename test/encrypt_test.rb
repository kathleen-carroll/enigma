require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/shift'
require './lib/offset'
require './lib/key'
require './lib/encrypt'

class ShiftTest < Minitest::Test
  def setup
    @offset1 = Offset.new
    @key1 = Key.new
    @shift = Shift.new(@key1, @offset1)
    @message = "Kathleen"
    @encrypt = Encrypt.new(@message, @key1, @offset1)
  end

  def test_it_exists
    assert_instance_of Encrypt, @encrypt
  end

  def test_it_has_attributes
    expected = {"a" => ["K", "l"],
             "b" => ["a", "e"],
             "c" => ["t", "e"],
             "d" => ["h", "n"]}
    assert_equal expected, @encrypt.message_breakout
  end
end
