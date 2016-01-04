class Star1


  MATCHER = /(?<action>gain|lose) (?<n>\d+)/

  def initialize
    @n = 8
    lines = []
    File.foreach('input.txt') do |line|
      lines << line.chomp
    end
    @distances = Array.new(@n) { Array.new(@n, 0) }

    k = 0
    @n.times do |i|
      @n.times do |j|
        if i != j
          @distances[i][j] += parse(lines[k])
          @distances[j][i] += parse(lines[k])
          k+=1
        end
      end
    end

    count_happ
    add_me
    count_happ
  end

  def count_happ
    max = -1
    (0..(@n-1)).to_a.permutation.to_a.each do |perm|
      happ = @distances[perm[0]][perm[-1]]
      (0..(@n-2)).each do |i|
        happ += @distances[perm[i]][perm[i+1]]
      end
      max = happ if happ > max
    end

    puts max
  end

  def add_me
    @n += 1
    @distances.each { |arr| arr.push(0) }
    @distances.push Array.new(@n, 0)
  end

  def parse(line)
    result = MATCHER.match(line)
    if result[:action] == 'gain'
      result[:n].to_i
    else
      -result[:n].to_i
    end
  end

end

Star1.new
