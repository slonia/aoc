require 'pry'
class Star
  ROW = 2947
  COL = 3029

  MULT = 252533
  DIV = 33554393

  def initialize
    size = [ROW, COL].max * 2
    @a = Array.new(size) { Array.new(size, 0) }
    i = 0
    j = 0
    el_proc = 0
    cur_diag = 1
    value = 20151125
    0.upto(size**2-1) do
      break if @a[i].nil?
      @a[i][j] = value
      value = (value * MULT)%DIV
      el_proc += 1
      if el_proc == cur_diag
        el_proc = 0
        i = cur_diag
        j = 0
        cur_diag += 1
      else
        i -= 1
        j += 1
      end
    end
    # puts @a.map {|a| a.join(' ')}
    puts @a[ROW-1][COL-1]
  end

end

Star.new
