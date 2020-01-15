require_relative 'test_helper'
# require 'minitest/autorun'
# require 'minitest/pride'
require './lib/shift'
require './lib/offset'
require './lib/key'
require './lib/encrypt'

class EncryptTest < Minitest::Test
  def setup
    @offset1 = Offset.new
    @key1 = Key.new("23431")
    @key1.value = 23431
    value = "23431"
    offset = "250894" #9236
    # @shift = Shift.new(@key1, @offset1)
    @message = "Kathleen"
    @message2 = "Kathlee!"
    @message3 = "K t!lee_"
    @message4 = "K!!h!een"
    @encrypt = Encrypt.new(@message, value)
    @encrypt1 = Encrypt.new(@message, value, offset)
    @encrypt2 = Encrypt.new(@message2, value)
    @encrypt3 = Encrypt.new(@message3, value)
    @encrypt4 = Encrypt.new(@message)
    @encrypt5 = Encrypt.new(@message4, value)
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
    assert_equal ["a", "e"], @encrypt.message_breakout["b"]
  end

  def test_it_can_shift_the_letters
    skip
    assert_equal "klillpur", @encrypt.shift_letters#(@shift)
    assert_equal "klillpu!", @encrypt2.shift_letters#(@shift)
    assert_equal ["l", "!"], @encrypt2.d
    assert_equal "kki!lpu_", @encrypt3.shift_letters#(@shift)
    assert_equal "pjlrqnxx", @encrypt1.shift_letters
  end

  def test_it_can_encode_the_shifted_letters
    assert_equal "klillpur", @encrypt.encode#(@shift)
    @encrypt2.shift_letters
    assert_equal ["l", "!"], @encrypt2.d
    assert_equal "klillpu!", @encrypt2.encode#(@shift)
    @encrypt5.shift_letters
    assert_equal ["k", "!"], @encrypt5.a
    assert_equal ["!", "p"], @encrypt5.b
    assert_equal ["!", "u"], @encrypt5.c
    assert_equal "kki!lpu_", @encrypt3.encode#(@shift)
    assert_equal "pjlrqnxx", @encrypt1.encode
  end

  def test_it_can_create_new_key_and_offset
    assert_instance_of Key, @encrypt4.key
    assert_equal 5, @encrypt4.key.value.to_s.length
    assert_instance_of String, @encrypt4.key.value
    assert_instance_of Offset, @encrypt4.offset
    # assert_equal '130120', @encrypt4.offset.date
  end

  def test_it_generates_random_key_and_offset
    @encrypt4.stub(:key, "23770") do
      assert_equal "23770", @encrypt4.key
    end

    @encrypt4.stub(:offset, "8971") do
      assert_equal "8971", @encrypt4.offset
    end
  end
end
