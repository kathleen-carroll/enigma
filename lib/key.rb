class Key
  attr_reader :value

  def initialize
    @value ||= key_generator
  end

  def key_generator
    key_num = 5
    key = ""
    key_num.times do
      key += rand(0..9).to_s
    end
    key.to_i
  end

  def a
    # @value.digits
    @value.digits.reverse[0..1].join#.to_i
    #if @value.digits[0..1].join[0] == "0"#@value.digits[0..1].join.include?("0")

    #elsif @value.digits[0..1].join[1] == "0"
    #else @value.digits[0..1].join.to_i
    #end
  end

  def b
    @value.digits.reverse[1..2].join
  end

  def c
    @value.digits.reverse[2..3].join
  end

  def d
    @value.digits.reverse[3..4].join
  end
end
