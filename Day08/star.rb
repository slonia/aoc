class Star1

  def initialize
    lines = []
    @total = 0
    @parsed = 0
    @encoded = 0
    File.foreach('input.txt') do |line|
      puts line
      parse(line)
    end
    puts @total - @parsed
    puts @encoded - @total
  end

  def parse(line)
    line = line.chomp

    @total += line.size
    line2 = line.gsub(/\\["\\]/,'a').gsub(/\\x\w{2}/, 'a')
    @parsed += line2.size - 2

    @encoded += line.size + 4 + line.scan(/\\["\\]/).size*2
    line3 = line.gsub(/\\["\\]/,'a')
    @encoded += line3.scan(/\\x\w{2}/).size
  end

end

Star1.new
