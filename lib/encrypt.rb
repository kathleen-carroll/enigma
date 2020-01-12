class Encrypt
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
end
