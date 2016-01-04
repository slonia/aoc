require 'digest'
md5 = Digest::MD5.new
START = 'iwrupvqb'
i = 0
five = false
loop do
  hex = md5.hexdigest(START + i.to_s)
  if hex.start_with?('00000') && !five
    puts i
    five = true
  end
  if hex.start_with?('000000')
    puts i
    break
  end
  i += 1
end
