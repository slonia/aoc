class Star1
  def initialize
    @lights = []
    File.foreach('input.txt') do |line|
      @lights << line.chomp.chars.map {|a| if a == '#' then true else false end }
    end
    @n, @m = @lights.size, @lights[0].size
    100.times do
      step2
    end
    enable_corners
    puts count_on
  end

  def step
    lights = Array.new(@n) { Array.new(@m, false)}
    @n.times do |i|
      @m.times do |j|
        neighbours = on_neighbours(i, j)
        if ((neighbours == 2 || neighbours == 3) && @lights[i][j]) ||
          ((neighbours == 3) && !@lights[i][j])
          lights[i][j] = true
        end
      end
    end

    @lights = lights
  end

  def step2
    enable_corners
    step
  end

  def enable_corners
    @lights[0][0] = 1
    @lights[0][@m-1] = 1
    @lights[@n-1][0] = 1
    @lights[@n-1][@m-1] = 1
  end

  def on_neighbours(i, j)
    on = 0
    right = j + 1 < @m
    left = j - 1 > -1
    top = i - 1 > -1
    bottom = i + 1 < @n
    on += [right && top && @lights[i-1][j+1], right && @lights[i][j+1], right && bottom && @lights[i+1][j+1],
      top && @lights[i-1][j], bottom && @lights[i+1][j],
      left && top && @lights[i-1][j-1], left && @lights[i][j-1], left && bottom && @lights[i+1][j-1]
    ].map {|a| if a then 1 else 0 end}.inject(:+)
  end


  def count_on
    @lights.map {|l| l.map {|a| if a then 1 else 0 end}.inject(:+)}.inject(:+)
  end
end

Star1.new
