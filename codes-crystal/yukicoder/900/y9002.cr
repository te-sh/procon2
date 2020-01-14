# URL: https://yukicoder.me/problems/no/9002

n = gets.not_nil!.to_i

(1..n).each do |i|
  if i%15 == 0
    puts "FizzBuzz"
  elsif i%5 == 0
    puts "Buzz"
  elsif i%3 == 0
    puts "Fizz"
  else
    puts i
  end
end
