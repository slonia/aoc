class Star1

  INPUT = '1113222113'
  N = 50

  def initialize
    @line = INPUT.split('').map(&:to_i)
    N.times { step }
    puts @line.size
  end

  def step
    new_line = []
    i = 0
    while i < @line.size
      c = 1
      while i + c < @line.size && @line[i] == @line[i+c]
        c += 1
      end
      new_line.push(c, @line[i])
      i += c
    end
    @line = new_line
  end

end

Star1.new
