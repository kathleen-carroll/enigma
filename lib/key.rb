class Key
  attr_accessor :value

  def initialize(key_value = key_generator)
    @value = key_value
    # ||= key_generator
  end

  def key_generator
    key_num = 5
    key = ""
    key_num.times do
      key += rand(0..9).to_s
    end
    key
    # .to_i
  end

  def a
    # @value.to_i.digits.reverse[0..1].join#.to_i
    @value[0..1]
    #this is a string value, may be changed to an integer
    #but have to worry about padding
  end

  def b
    # @value.to_i.digits.reverse[1..2].join
    @value[1..2]
  end

  def c
    # @value.to_i.digits.reverse[2..3].join
    @value[2..3]
  end

  def d
    # @value.to_i.digits.reverse[3..4].join
    @value[3..4]
  end
end
