require 'set'

class Star1
  def initialize
    @str = ''
    @moleculas = {}
    @perm = Set.new
    read
    process
  end

  def read
    File.foreach('input.txt') do |line|
      k, v = line.chomp.split(' => ')
      if v
        if @moleculas.has_key?(k)
          @moleculas[k] << v
        else
          @moleculas[k] = [v]
        end
      else
        @str = line.chomp
      end
    end
  end

  def construct(val, new_val)
    res = []
    indexes(@str, val).each do |i|
      left = (i == 0) ? '' : @str[0..(i-1)]
      right = @str[(i+val.size)..-1]
      res << (left + new_val + right)
    end
    res
  end

  def process
    @moleculas.each do |k, v|
      v.each do |new_val|
        @perm += construct(k, new_val)
      end
    end
    puts @perm.size
    # @perm.each {|a| puts a}
  end

  def indexes(str, needle)
    found = []
    current_index = -1
    while current_index = str.index(needle, current_index+1)
      found << current_index
    end
    found
  end

end

Star1.new
