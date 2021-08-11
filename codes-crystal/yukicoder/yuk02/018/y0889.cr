# URL: https://yukicoder.me/problems/no/889

def solve(io)
  n = io.get
  r = [] of String
  r << "Sosu!" if sosu?(n)
  r << "Heihosu!" if heihosu?(n)
  r << "Ripposu!" if ripposu?(n)
  r << "Kanzensu!" if kanzensu?(n)

  if r.size == 1
    io.put r.first
  else
    io.put n
  end
end

def sosu?(n)
  (2...n).all? { |i| n % i != 0 }
end

def heihosu?(n)
  (0..n).any? { |i| i * i == n }
end

def ripposu?(n)
  (0..n).any? { |i| i * i * i == n }
end

def kanzensu?(n)
  s = 0
  (1...n).each do |i|
    s += i if n % i == 0
  end
  s == n
end

require "lib/procon"

solve(ProconIO.new)
