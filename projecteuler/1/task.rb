arr = Array(1..999)
puts arr.select{|x|  x % 3 == 0 || x % 5 == 0}.reduce(:+)