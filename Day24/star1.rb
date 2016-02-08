class Star1
  N = 3 # set to 4 for second part
  def initialize
    read
    min_length = 100
    N.times do
      result = knap_iter
      min_length = result.size if result.size < min_length
    end
    answer = nil
    @all_weights.combination(min_length).each do |comb|
      sum = comb.inject(:+)
      if sum == @goal
        enlightment = comb.inject(:*)
        answer = enlightment if answer.nil? || enlightment < answer
      end
    end
    puts answer
  end

  def knap_iter
    @a = Array.new(@count+1) { Array.new(@goal+1)}
    @used = []
    knap
    find(@count, @goal)
    @weights -= @used
    @count = @weights.size - 1
    @used
  end

  def read
    @all_weights = []
    total = 0
    @weights = [0]
    @count = 0
    File.foreach('input.txt') do |line|
      weight = line.chomp.to_i
      @weights << weight
      @all_weights << weight
      total += weight
      @count += 1
    end
    @goal = total / N
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
