# URL: https://yukicoder.me/problems/no/755

def solve(io)
  n, m = io.get2
  a = io.get_m(m, m, Int64)

  ac = a.map { |ai| CumulativeSum.new(ai) }

  n.times do
    x, y = io.get2; x -= 1; y -= 1
    ans = 0

    (0..y).each do |l|
      (y...m).each do |r|
        b = ac.map { |aci| aci[l..r] }

        s = Hash(Int64, Int32).new { 0 }
        s[0_i64] = 1
        sd = 0_i64
        (x+1...m).each do |d|
          sd += b[d]
          s[-sd] += 1
        end

        su = 0_i64
        (0..x).reverse_each do |u|
          su += b[u]
          ans += s[su] if s.has_key?(su)
        end
      end
    end

    io.put ans
  end
end

require "lib/procon"

require "lib/data_structure/cumulative_sum"

solve(ProconIO.new)
