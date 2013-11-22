def num(times)
  text = '1'
  arr = []
  times.to_i.times do
    str = ''
    char = '0'
    text.each_char do |c|
      if c == char
        arr[0] += 1
      else
        str += arr.join('').to_s
        arr.clear
        arr = [1,c]
      end
      char = c
    end
    str += arr.join('').to_s
    arr.clear
    text = str
  end
  text
end

puts num(40).length