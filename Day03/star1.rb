require 'set'

class Star1


  def initialize
    @houses = Set.new
    @x1, @y1 = 0, 0
    @x2, @y2 = 0, 0
    @houses << [@x1, @y]

    @chars = File.read('input.txt').chomp
    process(@chars)
  end

  def process(chars)
    chars.chars.each_with_ do |c|
      case c
      when '^'
        @y += 1
      when 'v'
        @y -= 1
      when '>'
        @x += 1
      when '<'
        @x -= 1
      end
      @houses << [@x, @y]
    end

    puts @houses.size
  end

  def process2
  end

end

Star1.new
