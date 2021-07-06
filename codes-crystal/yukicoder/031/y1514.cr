# URL: https://yukicoder.me/problems/no/1514

require "bit_array"

def main(io)
  n = io.get

  a = BitArray.new(n+1, true)
  b = Array.new(n+1, &.itself)

  (2..n.isqrt).each do |i|
    next unless a[i]

    j = i*2
    while j <= n
      a[i] = false
      j += i
    end

    i2 = j = i*i
    while j <= n
      while b[j] % i2 == 0
        b[j] //= i2
      end
      j += i2
    end
  end

  c = Array.new(n+1, 0)
  (1..n).each do |i|
    c[b[i]] += 1
  end

  io.put c.reduce(0) { |a, b| a + b*b }
end

require "lib/number_ext"

require "lib/procon_io"

main(ProconIO.new)
