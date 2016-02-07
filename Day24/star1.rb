class Star1
  def initialize
    read
    knap
    find(@count, @goal)
    puts @used.join(' ')
    puts @used.inject(:+)
    puts @used.inject(:*)
  end

  def read
    @total = 0
    @weights = [0]
    @count = 0
    File.foreach('input.txt') do |line|
      weight = line.chomp.to_i
      @weights << weight
      @total += weight
      @count += 1
    end
    @used = []
    @goal = @total / 3
    @a = Array.new(@count+1) { Array.new(@goal+1)}
  end

  def knap
    0.upto(@goal) {|i| @a[0][i] = 0}
    0.upto(@count) { |i| @a[i][0] = 0}
    1.upto(@count) do |k|
      1.upto(@goal) do |s|
        if s >= @weights[k]
          @a[k][s] = [@a[k-1][s], @a[k-1][s-@weights[k]] + @weights[k]].max
        else
          @a[k][s] = @a[k-1][s]
        end
      end
    end
  end

  def find(k, s)
    if @a[k][s] == 0
      return
    end
    if @a[k-1][s] == @a[k][s]
      find(k-1, s);
    else
      find(k-1, s - @weights[k]);
      @used.push(@weights[k])
    end
  end
end

Star1.new
