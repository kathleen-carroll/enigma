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
    @key1.value = 23431
    @shift = Shift.new(@key1, @offset1)
    @message = "Kathleen"
    @message2 = "Kathlee!"
    @message3 = "K t!lee_"
    @encrypt = Encrypt.new(@message, @key1, @offset1)
    @encrypt2 = Encrypt.new(@message2, @key1, @offset1)
    @encrypt3 = Encrypt.new(@message3, @key1, @offset1)
    #a = 23 + 4 = 27
    #b = 34 + 4 = 38
    #c = 43 + 0 = 43
    #d = 31 + 0 = 31

    #k = k
    #a = l
    #t = i
    #h = l
    #l = l
    #e = p
    #e = u
    #n = r
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

  def test_it_can_shift_the_letters
    assert_equal "klillpur", @encrypt.shift_letters(@shift)
    assert_equal "klillpu!", @encrypt2.shift_letters(@shift)
    assert_equal "kki!lpu_", @encrypt3.shift_letters(@shift)
  end
end
