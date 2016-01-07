class Deer

  attr_reader :distance
  attr_accessor :score

  def initialize(speed, time, rest)
    @speed = speed.to_i
    @time = time.to_i
    @rest = rest.to_i
    @riding = 0
    @resting = 0
    @distance = 0
    @score = 0
  end

  def step
    if (@riding < @time)
      @distance += @speed
      @riding += 1
    else
      if @resting < @rest
        @resting += 1
        if @resting == @rest
          @riding = 0
          @resting = 0
        end
      end
    end
  end
end

class Star1

  TIME = 2503
  MATCHER = /(?<name>\w+) can fly (?<speed>\d+) km\/s for (?<time>\d+) seconds, but then must rest for (?<rest>\d+) seconds./

  def initialize
    @deers = {}
    File.foreach('input.txt') do |line|
      values = MATCHER.match(line.chomp)
      @deers[values[:name]] = Deer.new(*values.to_a.last(3))
    end
    TIME.times { step }
    puts 'By distance'
    puts @deers.map {|k, v| v.distance }.max
    puts 'By score'
    puts @deers.map {|k, v| v.score }.max
  end

  def step
    @deers.each { |name, deer| deer.step }
    max_dist = @deers.map {|k, v| v.distance }.max
    @deers.each { |name, deer| deer.score += 1 if deer.distance == max_dist }
  end

end

Star1.new
