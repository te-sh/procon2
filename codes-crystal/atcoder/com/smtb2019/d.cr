# URL: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_d

def solve(io)
  n = io.get
  s = io.get(String)
  t = s.chars.map(&.to_i32)

  a = Array.new(10) { [] of Int32 }
  t.each_with_index do |ti, i|
    a[ti] << i
  end

  c = 0
  Array.new(10, &.itself).each_repeated_permutation(3) do |b|
    i1 = a[b[0]].bsearch { |i| i >= 0 }
    next if i1.nil?

    i2 = a[b[1]].bsearch { |i| i > i1 }
    next if i2.nil?

    i3 = a[b[2]].bsearch { |i| i > i2 }
    next if i3.nil?

    c += 1
  end

  io.put c
end

require "lib/procon"

solve(ProconIO.new)
