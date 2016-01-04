class Star1

  MATCHER = /capacity ([\-0-9]+), durability ([\-0-9]+), flavor ([\-0-9]+), texture ([\-0-9]+), calories ([\-0-9]+)/

  def initialize
    @lines = []
    File.foreach('input.txt') do |line|
      @lines << MATCHER.match(line.chomp).to_a.last(5).map(&:to_i)
    end
    process
  end

  def process
    max1 = -1
    max2 = -1
    0.upto(100) do |s|
      0.upto(100-s) do |b|
        0.upto(100-s-b) do |ch|
          0.upto(100-s-b-ch) do |c|
            if s+b+ch+c==100
              cap = s*@lines[0][0] + b*@lines[1][0] + ch*@lines[2][0] + c*@lines[3][0]
              dur = s*@lines[0][1] + b*@lines[1][1] + ch*@lines[2][1] + c*@lines[3][1]
              fl = s*@lines[0][2] + b*@lines[1][2] + ch*@lines[2][2] + c*@lines[3][2]
              txt = s*@lines[0][3] + b*@lines[1][3] + ch*@lines[2][3] + c*@lines[3][3]
              cal = s*@lines[0][4] + b*@lines[1][4] + ch*@lines[2][4] + c*@lines[3][4]
              score = [cap, 0].max * [dur, 0].max * [fl, 0].max * [txt, 0].max
              max1 = score if (score > max1)
              max2 = score if (score > max2) && (cal == 500)
            end
          end
        end
      end
    end
    puts max1
    puts max2
  end

end

Star1.new
