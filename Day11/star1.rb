class Star

  def initialize
    @pass = 'hxbxwxba'
    while !valid? do
      inc(@pass.size-1)
    end
    puts @pass
    inc(@pass.size-1)
    while !valid? do
      inc(@pass.size-1)
    end
    puts @pass
  end

  def valid?
    !@pass.match(/[iol]/) &&
    (@pass.match( /(.)\1.*(.)\2/).to_a.last(2).uniq.size == 2) &&
    incr?
  end

  def inc(i)
    c = @pass[i]
    if c.ord < 122
      @pass[i] = (c.ord+1).chr
    else
      @pass[i] = 'a'
      inc(i-1) if (i > -1)
    end
  end

  def incr?
    0.upto(@pass.size - 3) do |i|
      return true if @pass[i+2].ord == @pass[i+1].ord + 1 &&
        @pass[i+1].ord == @pass[i].ord+1
    end
    false
  end
end

Star.new

