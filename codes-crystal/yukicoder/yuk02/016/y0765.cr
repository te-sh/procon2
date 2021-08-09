# URL: https://yukicoder.me/problems/no/765

def solve(io)
  sf = io.get(String)
  sb = sf.reverse
  n = sf.size

  base = Random.rand((1 << 10)..(1 << 30))
  rhf = RollingHash.new_string(sf, base)
  rhb = RollingHash.new_string(sb, base)

  m = 0
  n.times do |i|
    af, ab = lr(i - 1)
    bf, bb = lr(i + 1)
    mt = Math.min(af, bb)
    t = mt < 0 ? 0 : (0..mt).bsearch { |x| rhf[bf, x+1] != rhb[ab, x+1] } || (mt + 1)
    max_u(m, t * 2)

    if af - t >= 0
      cf, cb = lr(af - t - 1)
      df, db = lr(bf + t)
      mu = Math.min(cf, db)
      u = mu < 0 ? 0 : (0..mu).bsearch { |x| rhf[df, x+1] != rhb[cb, x+1] } || (mu + 1)
      max_u(m, t * 2 + u * 2 + 1)
    end

    if bb - t >= 0
      cf, cb = lr(af - t)
      df, db = lr(bf + t + 1)
      mu = Math.min(cf, db)
      u = mu < 0 ? 0 : (0..mu).bsearch { |x| rhf[df, x+1] != rhb[cb, x+1] } || (mu + 1)
      max_u(m, t * 2 + u * 2 + 1)
    end

    if i < n - 1 && sf[i] == sf[i + 1]
      af, ab = lr(i - 1)
      bf, bb = lr(i + 2)
      mt = Math.min(af, bb)
      t = mt < 0 ? 0 : (0..mt).bsearch { |x| rhf[bf, x+1] != rhb[ab, x+1] } || (mt + 1)
      max_u(m, t * 2 + 1)

      if af - t >= 0
        cf, cb = lr(af - t - 1)
        df, db = lr(bf + t)
        mu = Math.min(cf, db)
        u = mu < 0 ? 0 : (0..mu).bsearch { |x| rhf[df, x+1] != rhb[cb, x+1] } || (mu + 1)
        max_u(m, t * 2 + u * 2 + 2)
      end

      if bb - t >= 0
        cf, cb = lr(af - t)
        df, db = lr(bf + t + 1)
        mu = Math.min(cf, db)
        u = mu < 0 ? 0 : (0..mu).bsearch { |x| rhf[df, x+1] != rhb[cb, x+1] } || (mu + 1)
        max_u(m, t * 2 + u * 2 + 2)
      end
    end
  end

  io.put m
end

macro lr(x)
  { {{x}}, n-({{x}})-1 }
end

require "lib/procon"

require "lib/data_structure/rolling_hash"

solve(ProconIO.new)
