class Star1

  TARGET = 29_000_000

  def initialize
    @dividers = {}
    start = 400_000
    loop do
      # puts start
      r = for_house(start)
      if r >= TARGET
        break
      end
      start += 1
    end
    puts "answer is: #{start}"
  end

  def for_house(n)
    result = 0
    1.upto(n) do |i|
      result += 10 * i if will_visit(n, i)
    end
    result
  end

  def will_visit(n, i)
    n%i == 0
  end
end

Star1.new
