class Star
  def initialize(letter)
    @data = {}
    @letter = letter
    read
    process(@letter)
  end

  def read
    File.foreach('input.txt') do |line|
      value, key = line.chomp.split(' -> ')
      @data[key] = {command: value, value: nil}
    end
  end

  def process(wire)
    if @data[wire][:value]
      return @data[wire][:value]
    else
      @data[wire][:value] = compute(wire)
    end
  end

  def compute(wire)
    if wire.match(/\d+/)
      return wire.to_i
    elsif @data[wire][:value]
      return @data[wire][:value]
    else
      ops = @data[wire][:command].split(' ')
      case ops.size
      when 1
        @data[wire][:value] = compute(ops[0])
      when 2
        @data[wire][:value] = ~ compute(ops[1])
      when 3
        case ops[1]
        when 'AND'
          @data[wire][:value] = compute(ops[0]) & compute(ops[2])
        when 'OR'
          @data[wire][:value] = compute(ops[0]) | compute(ops[2])
        when 'LSHIFT'
          @data[wire][:value] = compute(ops[0]) << compute(ops[2])
        when 'RSHIFT'
          @data[wire][:value] = compute(ops[0]) >> compute(ops[2])
        end
      end
    end
  end

  def answer
    puts @data[@letter][:value]
  end

  def set(letter, value)
    @data[@letter][:value] = value
  end
end

Star.new('a').answer
