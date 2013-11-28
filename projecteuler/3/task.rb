require 'prime'

#num = 13195
num = 600851475143
prime_num = 1

while (num >= prime_num) do
  if (prime_num.prime? && (num % prime_num == 0))
    max_prime_factors = prime_num
    num = num / prime_num
  else
    prime_num += 2
  end
end

puts max_prime_factors