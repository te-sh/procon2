# :::::::::::::::::::: lib/math/misc
require "lib/ext/number"

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
# ax + by = g を満たす x, y の 1 つを返します
#
def ext_gcd(a : T, b : T) forall T
  if a == 0
    {b, T.new(0), T.new(1)}
  else
    g, x, y = ext_gcd(b % a, a)
    {g, y - (b // a) * x, x}
  end
end

#
# n のビットによる部分集合になっている数値を列挙します
# include_zero が true の場合は部分集合に 0 を含めます
#
def bit_subsets(a : Int, includes_zero = false)
  n = i = a
  if includes_zero
    while i >= 0
      yield i & n
      i = (i & n) - 1
    end
  else
    while i > 0
      yield i
      i = (i - 1) & n
    end
  end
end

#
# 高速ゼータ変換を行います
# 集合 S の部分集合 T についての値を合成します
#
def bit_zeta_trans_subset(n : Int, f : Array(T), &compose : (T, T) -> T) forall T
  g = Array.new(1 << n) { |i| f[i] }
  n.times do |i|
    (1 << n).times do |j|
      if j >> i & 1 != 0
        g[j] = compose.call(g[j], g[j ^ (1 << i)])
      end
    end
  end
  g
end

#
# 高速ゼータ変換を行います
# 集合 S を包含する集合 T についての値を合成します
#
def bit_zeta_trans_superset(n : Int, f : Array(T), &compose : (T, T) -> T) forall T
  g = Array.new(1 << n) { |i| f[i] }
  n.times do |i|
    (1 << n).times do |j|
      if j >> i & 1 == 0
        g[j] = compose.call(g[j], g[j ^ (1 << i)])
      end
    end
  end
  g
end
# ::::::::::::::::::::
