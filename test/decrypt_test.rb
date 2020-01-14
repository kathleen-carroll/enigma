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
    offset = "250894" #9236
    @shift = Shift.new(@key1, @offset1)
    @message = "Kathleen"
    @decrypt_message = "pjlrqnxx"
    @encrypt = Encrypt.new(@message, value, offset)
    @decrypt = Decrypt.new(@decrypt_message, value, offset)
    @decrypt2 = Decrypt.new(@decrypt_message, value)
  end

  def test_it_exists
    assert_instance_of Decrypt, @decrypt
  end

  def test_it_can_generate_a_new_key_and_offset
    assert_equal "23431", @decrypt.key.value
    assert_equal "250894", @decrypt.offset.date
    assert_equal "23431", @decrypt2.key.value
    assert_equal "130120", @decrypt2.offset.date
  end

  def test_it_has_attributes
  end
end
