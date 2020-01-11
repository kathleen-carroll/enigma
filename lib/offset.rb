class Offset
  attr_reader :date

  def initialize
    @date ||= get_date
  end

  def get_date
    Date.today.to_s
    yy = Date.today.year.to_s[-2..-1].rjust(2, "0")
    mm = Date.today.month.to_s.rjust(2, "0")
    dd = Date.today.day.to_s.rjust(2, "0")
    @date = dd + mm + yy
    get_date_code
    @date
  end

  def get_date_code
    square = @date.to_i ** 2
    @last_digits = square.to_s[-4..-1]
  end

  def a
    @last_digits[0]
  end

  def b
    @last_digits[1]
  end

  def c
    @last_digits[2]
  end

  def d
    @last_digits[3]
  end
end
