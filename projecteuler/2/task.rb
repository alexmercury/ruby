old_num = 1
cur_num = 2
sum = 0

while(cur_num < 4000000) do
  if cur_num.even?
    sum += cur_num
  end
  tmp_num = cur_num
  cur_num = old_num + cur_num
  old_num = tmp_num
end

puts sum