# URL: https://yukicoder.me/problems/no/873

def solve(io)
  n = io.get

  dp = Array.new(n + 1, &.itself)

  (1..n).each do |i|
    (1..Math.isqrt(i)).each do |j|
      min_u(dp[i], dp[i - j * j] + j)
    end
  end

  r = ""
  u = false
  until n == 0
    m = Math.isqrt(n)
    hit = false
    1.step(to: m, by: 2).each do |i|
      if dp[n - i * i] == dp[n] - i
        hit = true
        r += part(i, '0')
        n -= i * i
        break
      end
    end
    next if hit

    m = m // 2 * 2
    iter = u ? 2.step(to: m, by: 2) : m.step(to: 2, by: -2)
    iter.each do |i|
      if dp[n - i * i] == dp[n] - i
        hit = true
        r += part(i, u ? '1' : '0')
        n -= i * i
        u = !u
        break
      end
    end
  end

  io.put r
end

def part(len, start)
  r = Array(Char).new(len)
  c = start
  len.times do |i|
    r << c
    c = c == '0' ? '1' : '0'
  end
  r.join
end

require "lib/procon"

solve(ProconIO.new)
