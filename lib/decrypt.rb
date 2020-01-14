require_relative 'encrypt'

class Decrypt < Encrypt
  attr_reader :key, :offset, :message

  def initialize(message, key_value, offset_value = offset_gen)
    @message = message
    @key ||= Key.new(key_value)
    @offset ||= Offset.new(offset_value)
  end

  def offset_gen
    @offset = Offset.new
  end

  def decode
    shift = Shift.new(@key, @offset)
    # encoded = {}
    a = []
    b = []
    c = []
    d = []

    message_breakout.each do |shift_value, letters|
      letters.each do |letter|
        if shift_value == "a" && shift.character_position.key(letter.downcase) != nil
          current_position = shift.character_position.key(letter.downcase).to_i
          lookup_value = current_position - shift.a%27
          lookup_value = current_position + (27 - shift.a%27) if shift.a%27 > current_position
          lookup_value = 27 if shift.a%27 == current_position
          # lookup_value -= 27 if lookup_value > 27
          a << shift.character_position[lookup_value.to_s]
        elsif shift_value == "a" && shift.character_position.key(letter.downcase) == nil
          a << letter
        elsif shift_value == "b" && shift.character_position.key(letter.downcase) != nil
          current_position = shift.character_position.key(letter.downcase).to_i
          lookup_value = current_position - shift.b%27
          lookup_value = current_position + (27 - shift.b%27) if shift.b%27 > current_position
          lookup_value = 27 if shift.b%27 == current_position
          # lookup_value = shift.character_position.key(letter.downcase).to_i - shift.b%27
          # lookup_value -= 27 if lookup_value > 27
          b << shift.character_position[lookup_value.to_s]
        elsif shift_value == "b" && shift.character_position.key(letter.downcase) == nil
          b << letter
        elsif shift_value == "c" && shift.character_position.key(letter.downcase) != nil
          current_position = shift.character_position.key(letter.downcase).to_i
          lookup_value = current_position - shift.c%27
          lookup_value = current_position + (27 - shift.c%27) if shift.c%27 > current_position
          lookup_value = 27 if shift.c%27 == current_position
          # lookup_value = ((lookup_value * -1) + 1) + current_position if lookup_value > 27
          # lookup_value = 1 + (-lookup_value + shift.character_position.key(letter.downcase).to_i) if lookup_value/-lookup_value == -1
          c << shift.character_position[lookup_value.to_s]
        elsif shift_value == "c" && shift.character_position.key(letter.downcase) == nil
          c << letter
        elsif shift_value == "d" && shift.character_position.key(letter.downcase) != nil
          # lookup_value = shift.character_position.key(letter.downcase).to_i - shift.d%27
          # lookup_value -= 27 if lookup_value > 27
          current_position = shift.character_position.key(letter.downcase).to_i
          lookup_value = current_position - shift.d%27
          lookup_value = current_position + (27 - shift.d%27) if shift.d%27 > current_position
          lookup_value = 27 if shift.d%27 == current_position
          d << shift.character_position[lookup_value.to_s]
        elsif shift_value == "d" && shift.character_position.key(letter.downcase) == nil
        d << letter
        end
      end
    end

    encoded = {:a => a,
               :b => b,
               :c => c,
               :d => d}

    encoded

    shift_letters = []
    until encoded.values.flatten.length == 0
      encoded.each do |shift_key, letters|
        shift_letters << letters.first
        letters.shift
      end
    end
    shift_letters.join
  end


end
