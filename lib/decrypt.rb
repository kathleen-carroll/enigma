class Decrypt
  attr_reader :key, :offset, :message

  def initialize(message, key_value, offset_value = offset_gen)
    @message = message
    @key ||= Key.new(key_value)
    @offset ||= Offset.new(offset_value)
  end

  def offset_gen
    @offset = Offset.new
  end

end
