class Enigma
  attr_reader :encryption, :encrypt_message
  # def initialize
  #   @encryption = Hash.new(0)
  #   @decryption = Hash.new(0)
  # end

  def encrypt(message, key = nil, offset = nil)
    if offset == nil && key == nil
      @encryption = Encrypt.new(message)
    elsif offset == nil
      @encryption = Encrypt.new(message, key)
    else @encryption = Encrypt.new(message, key, offset)
    end

    @encrypt_message = @encryption.shift_letters
    {encryption: @encrypt_message, key: @encryption.key.value, date: @encryption.offset.date}
  end

  def decrypt(message, key = nil, offset = nil)
    if offset == nil && key == nil
      decrypt = Decrypt.new(message)
    elsif offset == nil
      decrypt = Decrypt.new(message, key)
    else
      decrypt = Decrypt.new(message, key, offset)
    end

    decrypt_message = decrypt.decode
    decryption = {decryption: decrypt_message, key: decrypt.key.value, date: decrypt.offset.date}
  end
end
