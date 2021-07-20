# URL: https://atcoder.jp/contests/panasonic2020/tasks/panasonic2020_e

def solve(io)
  a = io.get(String)
  b = io.get(String)
  c = io.get(String)
  na, nb, nc = a.size, b.size, c.size

  hab = Array.new(na+nb+nc*2+1, true)
  (-nb-nc..na+nc).each do |i|
    hab[i] = available?(a, b, i)
  end

  hac = Array.new(na+nb*2+nc+1, true)
  (-nb-nc..na+nb).each do |i|
    hac[i] = available?(a, c, i)
  end

  hbc = Array.new(na*2+nb*3+nc*3+1, true)
  (-na-nb-nc*2..na+nb*2+nc).each do |i|
    hbc[i] = available?(b, c, i)
  end

  m = 10**6
  (-b.size-c.size..a.size+c.size).each do |ib|
    (-b.size-c.size..a.size+b.size).each do |ic|
      if hab[ib] && hac[ic] && hbc[ic-ib]
        min_u(m, {a.size, ib + b.size, ic + c.size}.max - {0, ib, ic}.min)
      end
    end
  end

  io.put m
end

def available?(a, b, i)
  (0...a.size).all? do |ia|
    ib = -i + ia
    !(0...b.size).includes?(ib) || a[ia] == '?' || b[ib] == '?' || a[ia] == b[ib]
  end
end

require "lib/procon"

solve(ProconIO.new)
