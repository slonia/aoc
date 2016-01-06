class Star1

  MATCHER = /(?<action>on|off|toggle) (?<x1>\d+),(?<y1>\d+) through (?<x2>\d+),(?<y2>\d+)/

  def initialize
    @lights = Array.new(1000) { Array.new(1000, 0) }
    @lights2 = Array.new(1000) { Array.new(1000, 0) }
    File.foreach('input.txt') do |line|
      process(line.chomp)
    end
    puts @lights.map {|a| a.inject(:+)}.inject(:+)
    puts @lights2.map {|a| a.inject(:+)}.inject(:+)
  end

  def process(line)
    action, x1, y1, x2, y2 = MATCHER.match(line).to_a.last(5)
    x1 = x1.to_i
    x2 = x2.to_i
    y1 = y1.to_i
    y2 = y2.to_i
    case action
    when 'on'
      x1.upto(x2).each do |i|
        y1.upto(y2).each do |j|
          @lights[i][j] = 1
          @lights2[i][j] += 1
        end
      end
    when 'off'
      x1.upto(x2).each do |i|
        y1.upto(y2).each do |j|
          @lights[i][j] = 0
          @lights2[i][j] -= 1 if  @lights2[i][j] != 0
        end
      end
    when 'toggle'
      x1.upto(x2).each do |i|
        y1.upto(y2).each do |j|
          @lights[i][j] = 1 -  @lights[i][j]
          @lights2[i][j] += 2
        end
      end
    end
  end

end

Star1.new
