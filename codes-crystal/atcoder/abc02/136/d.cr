# URL: https://atcoder.jp/contests/abc136/tasks/abc136_d

def solve(io)
  s = io.get(String)

  c = Array.new(s.size, 0)
  i = 0
  s.scan(/(R+)L+/) do |m|
    l = m[0].size
    r = m[1].size
    l.times do |j|
      c[i + ((r - j).even? ? r : r - 1)] += 1
    end
    i += l
  end

  io.put c
end

require "lib/procon"

solve(ProconIO.new)
