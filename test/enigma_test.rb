require_relative 'test_helper'
require './lib/shift'
require './lib/offset'
require './lib/key'
require './lib/encrypt'
require './lib/decrypt'
require './lib/enigma'

class EngimaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_encrypt
    expected = {
    encryption: "keder ohulw",
    key: "02715",
    date: "040895"
  }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
    assert_instance_of Encrypt, @enigma.encryption
    assert_equal "02715", @enigma.encryption.key.value
    assert_equal "keder ohulw", @enigma.encrypt_message
  end

  def test_it_can_decrypt
    expected = {
    decryption: "hello world",
    key: "02715",
    date: "040895"
  }
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_can_encrypt_and_decrypt_without_offset
    expected_e = {:encryption=>"nib udmcxpu", :key=>"02715", :date=>"140120"}
    encrypted = @enigma.encrypt("hello world", "02715")
    assert_equal expected_e, encrypted

    decrypted = @enigma.decrypt(encrypted[:encryption], "02715")
    expected_d = {:decryption=>"hello world", :key=>"02715", :date=>"140120"}
    assert_equal expected_d, decrypted
    assert_equal "02715", decrypted[:key]
  end

  def test_it_can_encrypt_without_offset_or_key
    enigma = @enigma.encrypt("hello world")

    @enigma.stub(:encrypt, "12354") do
      assert_equal "12354", @enigma.encrypt(@message)
    end

    @enigma.stub(:encrypt, "250894") do
      assert_equal "250894", @enigma.encrypt(@message)
    end

    assert_instance_of Hash, enigma
    assert_equal 5, enigma[:key].length
    assert_equal "140120", enigma[:date]

    enigma.stub(:key, "12345") do
      assert_equal "12345", enigma.key
    end

    # enigma.stub(:date, "041194") do
    #   assert_equal "041194", enigma.date
    # end
  end
end
