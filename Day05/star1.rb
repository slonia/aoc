class Star1

  FORBIDDEN = /ab|cd|pq|xy/

  def initialize
    @i = 0
    @j = 0
    File.foreach('input.txt') do |line|
      @i +=1 if nice?(line.chomp)
      @j +=1 if nice2?(line.chomp)
    end
    puts @i
    puts @j
  end

  def nice?(str)
    str.count('aeiou') > 2 &&
    str.match(/(.)\1/) &&
    !str.match(FORBIDDEN)
  end

  def nice2?(str)
    str.match(/(.{2}).*\1/) &&
    str.match(/(.).\1/)
  end

end

Star1.new
