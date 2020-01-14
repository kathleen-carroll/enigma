class Shift
  attr_reader :characters, :key, :offset

  def initialize(key, offset_value)
    @key = key
    @offset = offset_value
    @characters = ("a".."z").to_a << " "
  end

  def a
    @key.a.to_i + @offset.a.to_i
  end

  def b
    @key.b.to_i + @offset.b.to_i
  end

  def c
    @key.c.to_i + @offset.c.to_i
  end

  def d
    @key.d.to_i + @offset.d.to_i
  end

  def character_position
    num = 1
    character_position = @characters.reduce({}) do |character_position, character| #length.times do
      character_position[num.to_s] = character
      num += 1
      character_position
    end
  end
end
