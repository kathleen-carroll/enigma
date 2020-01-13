class Encrypt
  attr_reader :key, :offset, :message

  def initialize(message, key = key_gen, offset = offset_gen)
    @message = message
    @key = key
    @offset = offset
  end

  def key_gen
    @key = Key.new
  end

  def offset_gen
    @offset = Offset.new
  end

  def message_breakout
    message_split = @message.split("")
    letters = ["a", "b", "c", "d"]
    num = 0
    groups = []
    until message_split.length == 0
      groups << message_split[0..3]
      message_split.shift(4)
    end

    a = []
    b = []
    c = []
    d = []

    groups.each do |group|
      a << group[0]
      b << group[1]
      c << group[2]
      d << group[3]
    end

    coded = {"a" => a,
             "b" => b,
             "c" => c,
             "d" => d}

    coded
    # letters.reduce({}) do |coded, letter|
    #   coded[letter] = "letter"
    # end

    # message_split.reduce({}) do |coded, letter|
    #   require "pry"; binding.pry
    #   if letters[num] == nil
    #     num = 0
    #     coded[letter] = letters[num]
    #     num += 1
    #   else
    #     coded[letter] = letters[num]
    #     num += 1
    #   end
    #   coded
    # end
  end

  def shift_letters(shift)
    # encoded = {}
    a = []
    b = []
    c = []
    d = []

    message_breakout.each do |shift_value, letters|
      letters.each do |letter|
        if shift_value == "a" && shift.character_position.key(letter.downcase) != nil
          lookup_value = shift.character_position.key(letter.downcase).to_i + shift.a%27
          lookup_value -= 27 if lookup_value > 27
          a << shift.character_position[lookup_value.to_s]
        elsif shift_value == "a" && shift.character_position.key(letter.downcase) == nil
          a << letter
        elsif shift_value == "b" && shift.character_position.key(letter.downcase) != nil
          lookup_value = shift.character_position.key(letter.downcase).to_i + shift.b%27
          lookup_value -= 27 if lookup_value > 27
          b << shift.character_position[lookup_value.to_s]
        elsif shift_value == "b" && shift.character_position.key(letter.downcase) == nil
          b << letter
        elsif shift_value == "c" && shift.character_position.key(letter.downcase) != nil
          lookup_value = shift.character_position.key(letter.downcase).to_i + shift.c%27
          lookup_value -= 27 if lookup_value > 27
          c << shift.character_position[lookup_value.to_s]
        elsif shift_value == "c" && shift.character_position.key(letter.downcase) == nil
          c << letter
        elsif shift_value == "d" && shift.character_position.key(letter.downcase) != nil
          lookup_value = shift.character_position.key(letter.downcase).to_i + shift.d%27
          lookup_value -= 27 if lookup_value > 27
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
