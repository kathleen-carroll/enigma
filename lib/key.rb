class Key
  attr_accessor :value

  def initialize(key_value = key_generator)
    @value = key_value
  end

  def key_generator
    key_num = 5
    key = ""
    key_num.times do
      key += rand(0..9).to_s
    end
    key
  end

  def a
    @value[0..1]
  end

  def b
    @value[1..2]
  end

  def c
    @value[2..3]
  end

  def d
    @value[3..4]
  end
end
