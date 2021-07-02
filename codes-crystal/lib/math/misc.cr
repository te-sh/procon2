# :::::::::::::::::::: lib/math/misc
#
# a = Math.min(a, b) に置き換えます
#
macro min_u(a, b)
  {{a}} = Math.min({{a}}, {{b}})
end

#
# a = Math.max(a, b) に置き換えます
#
macro max_u(a, b)
  {{a}} = Math.max({{a}}, {{b}})
end

#
# √n を超えない最大の整数を返します
#
def isqrt(n : Int32)
  m = 46340
  r = (1..m).bsearch { |i| i**2 > n }
  r.nil? ? m : r - 1
end

#
# 拡張ユークリッドの互除法で a, b の最大公約数 g と
# ax + by = g を満たす x, y の 1 つを返します.
#
def ext_gcd(a : T, b : T) forall T
  if a == 0
    {b, T.new(0), T.new(1)}
  else
    g, x, y = ext_gcd(b%a, a)
    {g, y-(b//a)*x, x}
  end
end
# ::::::::::::::::::::
