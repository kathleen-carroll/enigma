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
    offset = "250894"
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
    expected1 = {
      :a => ["k", "l"],
      :b => ["l", "p"],
      :c => ["i", "u"],
      :d => ["l", "r"]
    }
    expected2 = {:a => ["k", "l"],
      :b => ["l", "p"],
      :c => ["i", "u"],
      :d => ["l", "!"]}
    expected3 = {:a => ["k", "l"],
      :b => ["k", "p"],
      :c => ["i", "u"],
      :d => ["!", "_"]}
    expected4 = {:a => ["p", "q"],
      :b => ["j", "n"],
      :c => ["l", "x"],
      :d => ["r", "x"]}

    assert_equal expected1, @encrypt.shift_letters
    assert_equal expected2, @encrypt2.shift_letters
    assert_equal expected3, @encrypt3.shift_letters
    assert_equal expected4, @encrypt1.shift_letters
  end

  def test_it_can_encode_the_shifted_letters
    assert_equal "klillpur", @encrypt.encode
    @encrypt2.shift_letters
    assert_equal ["l", "!"], @encrypt2.d
    assert_equal "klillpu!", @encrypt2.encode
    @encrypt5.shift_letters
    assert_equal ["k", "!"], @encrypt5.a
    assert_equal ["!", "p"], @encrypt5.b
    assert_equal ["!", "u"], @encrypt5.c
    assert_equal "kki!lpu_", @encrypt3.encode
    assert_equal "pjlrqnxx", @encrypt1.encode
  end

  def test_it_can_create_new_key_and_offset
    assert_instance_of Key, @encrypt4.key
    assert_equal 5, @encrypt4.key.value.to_s.length
    assert_instance_of String, @encrypt4.key.value
    assert_instance_of Offset, @encrypt4.offset
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
