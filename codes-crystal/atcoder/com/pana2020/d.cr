# URL: https://atcoder.jp/contests/panasonic2020/tasks/panasonic2020_d

def solve(io)
  n = io.get

  a = [{"a", 'a'}]
  (2..n).each do |i|
    b = Array({String, Char}).new
    a.each do |c, d|
      ('a'..d+1).each do |j|
        b << {c + j, Math.max(j, d)}
      end
    end
    a = b
  end

  r = a.map { |c, _| c }.sort
  r.each do |ri|
    io.put ri
  end
end

require "lib/procon"

solve(ProconIO.new)
