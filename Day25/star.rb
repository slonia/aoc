require 'pry'
class Star
  ROW = 2947
  COL = 3029

  MULT = 252533
  DIV = 33554393
  START = 20151125

  def initialize
    n = num(ROW, COL)
    puts value_at(n)
  end

  def value_at(exponent)
    c = 1
    (exponent-1).times do
      c = (c * MULT) % DIV
    end
    (START*c)%DIV
  end

  def num(j, i)
    (i*i + j*j + 2*i*j -i -3*j+2)/2
  end

end

Star.new
