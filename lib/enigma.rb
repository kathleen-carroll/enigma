class Enigma
  attr_reader :encryption, :encrypt_message

  def encrypt(message, key = nil, offset = nil)
    if offset == nil && key == nil
      @encryption = Encrypt.new(message)
    elsif offset == nil
      @encryption = Encrypt.new(message, key)
    else @encryption = Encrypt.new(message, key, offset)
    end

    @encrypt_message = @encryption.encode 
    {encryption: @encrypt_message, key: @encryption.key.value, date: @encryption.offset.date}
  end

  def decrypt(message, key, offset = nil)
    if offset == nil
      decrypt = Decrypt.new(message, key)
    else
      decrypt = Decrypt.new(message, key, offset)
    end

    decrypt_message = decrypt.decode
    decryption = {decryption: decrypt_message, key: decrypt.key.value, date: decrypt.offset.date}
  end
end
