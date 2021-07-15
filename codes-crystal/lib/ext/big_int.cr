# :::::::::::::::::::: lib/ext/big_int
#
# BigInt を拡張します
#
struct BigInt
  #
  # "おそらく素数" かどうかを返します
  #
  def probab_prime?(rep : Int = 10)
    LibGMP.probab_prime_p(self, rep) >= 1
  end
end

@[Link("gmp")]
lib LibGMP
  fun probab_prime_p = __gmpz_probab_prime_p(op : MPZ*, rep : Int) : Int
end
# ::::::::::::::::::::
