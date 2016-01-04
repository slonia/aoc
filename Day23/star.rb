require 'pry'
class Star1

  SET = /(?<com>hlf|tpl|inc) (?<reg>[a-z])/
  JMP = /(?<com>jmp) (?<offset>[\-+0-9]+)/
  COND_JMP = /(?<com>jie|jio) (?<reg>[a-z]), (?<offset>[\-+0-9]+)/

  def initialize
    @regs = {"a" => 1, "b" => 0}
    @lines = []
    File.foreach('input.txt') do |line|
      @lines << line.chomp
    end
    line = 0
    while new_line = execute(line)
      line = new_line
    end
    puts @regs
  end

  def execute(n)
    return unless n < @lines.size
    line = @lines[n]
    if SET.match(line)
      com, reg = SET.match(line).to_a.last(2)
      case com
      when 'hlf'
        @regs[reg] /= 2
      when 'tpl'
        @regs[reg] *= 3
      when 'inc'
        @regs[reg] += 1
      end
      return n + 1
    elsif JMP.match(line)
      com, offset = JMP.match(line).to_a.last(2)
      return n + offset.to_i
    elsif COND_JMP.match(line)
      com, reg, offset = COND_JMP.match(line).to_a.last(3)
      case com
      when 'jie'
        return n + offset.to_i if @regs[reg].even?
      when 'jio'
        return n + offset.to_i if @regs[reg] == 1
      end
      return n + 1
    end
  end

end

Star1.new
