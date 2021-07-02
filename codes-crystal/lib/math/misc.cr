# :::::::::::::::::::: lib/math/misc
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
