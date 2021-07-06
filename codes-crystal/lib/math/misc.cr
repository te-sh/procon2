# :::::::::::::::::::: lib/math/misc
#
# a の n 乗を繰り返し2乗法で計算します
# 乗算方法は * です
#
def powr(a : T, n : Int, i : T = T.multiplicative_identity) forall T
  powr(a, n, i) { |a, b| a * b }
end

#
# a の n 乗を繰り返し2乗法で計算します
# 乗算方法を指定します
#
def powr(a : T, n : Int, i : T = T.multiplicative_identity, &block) forall T
  return i if n == 0
  r, b = i, a
  while n > 0
    r = yield r, b if n.bit(0) == 1
    b = yield b, b
    n >>= 1
  end
  r
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
