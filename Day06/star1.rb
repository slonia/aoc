class Star1

  N = 8

  def initialize
    lines = []
    File.foreach('input.txt') do |line|
      lines << line.chomp
    end
    @distances = Array.new(N) { Array.new(N, 0) }

    k = 0

    N.times do |i|
      ((i + 1)...N).each do |j|
        @distances[i][j] = parse(lines[k])
        @distances[j][i] = @distances[i][j]
        k += 1
      end
    end

    max = -1
    (0..(N-1)).to_a.permutation.to_a.each do |perm|
      dist = 0
      (0..(N-2)).each do |i|
        dist += @distances[perm[i]][perm[i+1]]
      end
      max = dist if dist > max
    end

    puts max
  end

  def parse(line)
    line.split.last.to_i
  end

end

Star1.new
