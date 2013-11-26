def numeric_range(count)
  text = '1'
  arr = []
  count.times do
    str = ''
    char = '0'
    puts text
    text.each_char do |c|
      if c == char
        arr[0] += 1
      else
        str += arr.join('').to_s
        arr.clear
        arr = [1, c]
      end
      char = c
    end
    str += arr.join('').to_s
    arr.clear
    text = str
  end
  text
end

puts numeric_range(3).length