require 'set'

class Star1

  VOLUME = 150

  def initialize
    @containers = []
    @n = 0
    @min_n = 900
    @min_n_count = 0
    File.foreach('input.txt') do |line|
      @containers << line.chomp.to_i
    end
    process
    puts @n
    puts @min_n_count
  end

  def process
    1.upto(@containers.size).each do |n|
      min_n_count = 0
      @containers.combination(n).each do |comb|
        if comb.inject(:+) == VOLUME
          @n += 1
          min_n_count += 1
        end
      end
      if min_n_count > 0 && n < @min_n
        @min_n = n
        @min_n_count = min_n_count
      end
    end
  end

end

Star1.new
