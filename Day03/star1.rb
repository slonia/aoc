require 'set'

class Star1
  def initialize
    @chars = File.read('input.txt').chomp
    @houses = Set.new
    @x1, @y1 = 0, 0
    @x2, @y2 = 0, 0
    @houses << [@x1, @y1]

    process(@chars)

    @houses.clear
    @x1, @y1 = 0, 0
    @x2, @y2 = 0, 0
    @houses << [@x1, @y1]
    process(@chars, true)
  end

  def process(chars, robo = false)
    chars.chars.each_with_index do |c, i|
      house = if (robo && (i % 2 == 1)) then robo_santa(c) else santa(c) end
      @houses << house
    end

    puts @houses.size
  end

  def santa(c)
    case c
    when '^'
      @y1 += 1
    when 'v'
      @y1 -= 1
    when '>'
      @x1 += 1
    when '<'
      @x1 -= 1
    end
    [@x1, @y1]
  end

  def robo_santa(c)
    case c
    when '^'
      @y2 += 1
    when 'v'
      @y2 -= 1
    when '>'
      @x2 += 1
    when '<'
      @x2 -= 1
    end
    [@x2, @y2]
  end
end

Star1.new
