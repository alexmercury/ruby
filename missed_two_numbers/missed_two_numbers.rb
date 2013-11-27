module MissedTwoNumbers

  extend self

  def generate_array(count)
    num_array = Array(1..count)
    2.times{num_array.delete_at(Random.rand(count-1))}
    num_array
  end

  def find_missed_numbers(arr1)
   Array(1..(arr1.length + 2)) - arr1
  end

end

arr = MissedTwoNumbers.generate_array(20)
puts arr.to_s
puts  MissedTwoNumbers.find_missed_numbers(arr).to_s