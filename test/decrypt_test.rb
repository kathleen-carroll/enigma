require_relative 'test_helper'
require './lib/shift'
require './lib/offset'
require './lib/key'
require './lib/encrypt'
require './lib/decrypt'

class DecryptTest < Minitest::Test
  def setup
    @offset1 = Offset.new
    @key1 = Key.new
    @key1.value = 23431
    value = "23431"
    offset = "250894" 
    @shift = Shift.new(@key1, @offset1)
    @message = "Kathleen"
    @decrypt_message = "pjlrqnxx"
    @decrypt_message2 = "klillpur"
    @decrypt_message3 = "klillpu!"
    @decrypt_message4 = "kki!lpu_"
    @decrypt_message5 = "K!!l!pur"
    @encrypt = Encrypt.new(@message, value, offset)
    @encrypt2 = Encrypt.new(@message, value)
    @decrypt = Decrypt.new(@decrypt_message, value, offset)
    @decrypt2 = Decrypt.new(@decrypt_message2, value)
    @decrypt3 = Decrypt.new(@decrypt_message3, value)
    @decrypt4 = Decrypt.new(@decrypt_message4, value)
    @decrypt5 = Decrypt.new(@decrypt_message5, value)
  end

  def test_it_exists
    assert_instance_of Decrypt, @decrypt
  end

  def test_it_can_generate_a_new_key_and_offset
    assert_equal "23431", @decrypt.key.value
    assert_equal "250894", @decrypt.offset.date
    assert_equal "23431", @decrypt2.key.value
    assert_equal "140120", @decrypt2.offset.date
  end

  def test_it_shifts_letters_right
    expected1 = {
      "a" => ["p", "q"],
      "b" => ["j", "n"],
      "c" => ["l", "x"],
      "d" => ["r", "x"]
    }
    expected2 = {"a" => ["k", "l"],
      "b" => ["l", "p"],
      "c" => ["i", "u"],
      "d" => ["l", "r"]}
    expected3 = {"a" => ["k", "l"],
      "b" => ["l", "p"],
      "c" => ["i", "u"],
      "d" => ["l", "!"]}
    expected4 = {"a" => ["k", "l"],
      "b" => ["k", "p"],
      "c" => ["i", "u"],
      "d" => ["!", "_"]}

    assert_equal expected1, @decrypt.shift_letters_assign
    assert_equal expected2, @decrypt2.shift_letters_assign
    assert_equal expected3, @decrypt3.shift_letters_assign
    assert_equal expected4, @decrypt4.shift_letters_assign
  end

  def test_it_can_assign_unusual_values_correctly_to_groups
    assert_equal "kathleen", @decrypt.decode
    @decrypt2.shift_letters_assign
    assert_equal ["h", "n"], @decrypt2.d
    assert_equal "kathleen", @decrypt2.decode
    @decrypt5.shift_letters_assign
    assert_equal ["k", "!"], @decrypt5.a
    assert_equal ["!", "e"], @decrypt5.b
    assert_equal ["!", "e"], @decrypt5.c
  end

  def test_it_can_breakdown_the_message
    assert_equal "kathleen", @decrypt.decode
    assert_equal "kathleen", @decrypt2.decode
    assert_equal "kathlee!", @decrypt3.decode
    assert_equal "k t!lee_", @decrypt4.decode
  end
end
