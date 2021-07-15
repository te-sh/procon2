# URL: https://yukicoder.me/problems/no/767

def solve(io)
  h, w, k = io.get3
  a, b = io.get2_c(k)
  f = Array.new(k) { |i| Friend.new(a[i], b[i], i) }
  f.sort_by! { |fi| [fi.a, fi.b] }

  fc = Fact(Mint).new(h + w)

  g = Array.new(1 << k) do |i|
    c = Mint.new(-1) ** i.popcount
    sa = sb = 0
    k.times do |j|
      if i.bit?(j)
        ea, eb = f[j].a, f[j].b
        if ea >= sa && eb >= sb
          c *= fc.combi((ea - sa) + (eb - sb), ea - sa)
        else
          c = Mint.zero
          break
        end
        sa, sb = ea, eb
      end
    end
    c * fc.combi((h - sa) + (w - sb), h - sa)
  end

  h = bit_zeta_trans_subset(k, g) { |a, b| a + b }

  r = Array.new(1 << k, Mint.zero)
  (1 << k).times do |i1|
    i2 = 0
    k.times do |j|
      i2 = i2.set_bit(f[j].i) if i1.bit?(j)
    end
    r[i2] = h[i1]
  end

  r.each do |ri|
    io.put ri
  end
end

record Friend, a : Int32, b : Int32, i : Int32

require "lib/procon"

require "lib/math/misc"

require "lib/math/fact"

require "lib/math/mod_int"
ModInt.new_type(Mint, 10**8+7)

solve(ProconIO.new)
