class Shift
  def initialize(key, offset)
    @key = key
    @offset = offset
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
end
