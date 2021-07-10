# :::::::::::::::::::: lib/math/prime_factor
#
# 素数の列挙と素因数分解を行います
#
require "bit_array"

class PrimeFactor
  #
  # コンストラクタ
  # n 以下の素数を列挙します
  #
  def initialize(@n : Int32)
    s = (@n+1)//2
    sieve = BitArray.new(s, true)

    if @n < 2
      @primes = [] of Int32
      return
    end

    (1..(n.isqrt-1)//2).each do |p|
      if sieve[p]
        (p*3+1...s).step(p*2+1) do |q|
          sieve[q] = false
        end
      end
    end

    @primes = [2]
    (1...s).each do |p|
      @primes << p*2+1 if sieve[p]
    end
  end

  #
  # コンストラクタ
  # √n 以下の素数を列挙します
  #
  def self.sqrt(n : Int)
    self.new(n.isqrt.to_i32)
  end

  #
  # 列挙した素数を返します
  #
  getter primes : Array(Int32)

  #
  # 素因数とべき指数を表します
  #
  record Factor(T), prime : T, exp : Int32

  #
  # x の素因数分解の結果を返します
  #
  def div(x : T) forall T
    factors = [] of Factor(T)
    t = x.isqrt
    @primes.each do |p|
      break if p > t
      c = 0
      while x%p == 0
        c += 1
        x //= p
      end
      factors << Factor.new(T.new(p), c) if c > 0
      break if x == 1
    end
    factors << Factor.new(x, 1) if x > 1
    factors
  end

  #
  # x の約数の配列を返します
  #
  def divisors(x : T) forall T
    factors = div(x)
    r = divisors_proc(factors, 0, T.multiplicative_identity)
    r.sort!
  end

  # ---------- private methods

  def divisors_proc(factors : Array(Factor(T)), i : Int32, c : T) forall T
    return [c] if i == factors.size
    r = [] of T
    (0..factors[i].exp).each do |j|
      r.concat(divisors_proc(factors, i+1, c * factors[i].prime**j))
    end
    r
  end
end
# ::::::::::::::::::::
