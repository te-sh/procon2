module lib.math.gmp_int;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.math.gmp_int
/**
 ** GMP のラッパーです.
 **/
struct GmpInt
{
  pure nothrow @nogc @safe
  {
    /**
     ** long の値 v から作成します.
     **/
    this(long v)
    {
      __gmpz_init_set_si(&z, v);
    }
    /**
     ** コピーコンストラクタです.
     **/
    this(ref return scope const GmpInt v)
    {
      __gmpz_init_set(&z, &v.z);
    }
    /**
     ** デストラクタです.
     **/
    ~this()
    {
      __gmpz_clear(&z);
    }

    /**
     ** long に変換した値を返します.
     **/
    long toLong() const
    {
      return __gmpz_get_si(&z);
    }

    /**
     ** g == v かどうかを返します.
     ** v は GmpInt か Integral です.
     **/
    bool opEquals(const GmpInt v) const
    {
      return __gmpz_cmp(&z, &v.z) == 0;
    }
    /// ditto
    bool opEquals(T)(T v) const
      if (isIntegral!T)
    {
      return __gmpz_cmp_si(&z, v) == 0;
    }
    /**
     ** g > v ならば 1 を, g == v ならば 0 を, g < v ならば -1 を返します.
     ** v は GmpInt か Integral です.
     **/
    int opCmp(const GmpInt v) const
    {
      return __gmpz_cmp(&z, &v.z);
    }
    /// ditto
    int opCmp(T)(T v) const
      if (isIntegral!T)
    {
      return __gmpz_cmp_si(&z, v);
    }

    /**
     ** v を代入します.
     ** v は GmpInt か Integral です.
     **/
    ref GmpInt opAssign(const GmpInt v)
    {
      __gmpz_init_set(&z, &v.z);
      return this;
    }
    /// ditto
    ref GmpInt opAssign(T)(T v)
      if (isIntegral!T)
    {
      __gmpz_init_set_si(&z, v);
      return this;
    }

    /**
     ** g+v, g-v, g*v, g/v, g%v を返します.
     ** v は GmpInt です.
     **/
    GmpInt opBinary(string op)(const GmpInt v) const
      if (op == "+" || op == "-" || op == "*" || op == "/" || op == "%")
    {
      auto r = GmpInt(0);
      static      if (op == "+") __gmpz_add(&r.z, &z, &v.z);
      else static if (op == "-") __gmpz_sub(&r.z, &z, &v.z);
      else static if (op == "*") __gmpz_mul(&r.z, &z, &v.z);
      else static if (op == "/") __gmpz_tdiv_q(&r.z, &z, &v.z);
      else static if (op == "%") __gmpz_tdiv_r(&r.z, &z, &v.z);
      return r;
    }
    /**
     ** g+=v, g-=v, g*=v, g/=v, g%=v を計算します.
     ** v は GmpInt です.
     **/
    ref GmpInt opOpAssign(string op)(const GmpInt v)
      if (op == "+" || op == "-" || op == "*" || op == "/" || op == "%")
    {
      static      if (op == "+") __gmpz_add(&z, &z, &v.z);
      else static if (op == "-") __gmpz_sub(&z, &z, &v.z);
      else static if (op == "*") __gmpz_mul(&z, &z, &v.z);
      else static if (op == "/") __gmpz_tdiv_q(&z, &z, &v.z);
      else static if (op == "%") __gmpz_tdiv_r(&z, &z, &v.z);
      return this;
    }

    /**
     ** g+v, g-v, g*v, g/v, g%v, g^^v を返します.
     ** v は Integral です.
     **/
    GmpInt opBinary(string op, U)(U v) const
      if ((op == "+" || op == "-" || op == "*" || op == "/" || op == "%" || op == "^^")
          && isIntegral!U)
    {
      auto r = GmpInt(0);
      static      if (op == "+") __gmpz_add_ui(&r.z, &z, v);
      else static if (op == "-") __gmpz_sub_ui(&r.z, &z, v);
      else static if (op == "*") __gmpz_mul_ui(&r.z, &z, v);
      else static if (op == "/") __gmpz_tdiv_q_ui(&r.z, &z, v);
      else static if (op == "%") __gmpz_tdiv_r_ui(&r.z, &z, v);
      else static if (op == "^^") __gmpz_pow_ui(&r.z, &z, v);
      return r;
    }
    /**
     ** g+=v, g-=v, g*=v, g/=v, g%=v, g^^=v を計算します.
     ** v は long です.
     **/
    ref GmpInt opOpAssign(string op, U)(U v)
      if ((op == "+" || op == "-" || op == "*" || op == "/" || op == "%" || op == "^^")
          && isIntegral!U)
    {
      static      if (op == "+") __gmpz_add_ui(&z, &z, v);
      else static if (op == "-") __gmpz_sub_ui(&z, &z, v);
      else static if (op == "*") __gmpz_mul_ui(&z, &z, v);
      else static if (op == "/") __gmpz_tdiv_q_ui(&z, &z, v);
      else static if (op == "%") __gmpz_tdiv_r_ui(&z, &z, v);
      else static if (op == "^^") __gmpz_pow_ui(&z, &z, v);
      return this;
    }

    /**
     ** 絶対値を返します.
     **/
    GmpInt abs() const
    {
      auto r = GmpInt(0);
      __gmpz_abs(&r.z, &z);
      return r;
    }
    /**
     ** 平方根を超えない最大の整数を返します.
     **/
    GmpInt sqrt() const
    {
      auto r = GmpInt(0);
      __gmpz_sqrt(&r.z, &z);
      return r;
    }
    /**
     ** 1 になっているビットの数を返します.
     **/
    size_t popcnt() const
    {
      return __gmpz_popcount(&z);
    }
    /**
     ** 素数かどうかを返します. 内部では Miller-Rabin 法を使用しています.
     ** reps は Miller-Rabin 法の試行回数です.
     **/
    bool probabPrime(int reps = 20) const
    {
      return __gmpz_probab_prime_p(&z, reps) != 0;
    }
  }

  pure nothrow
  {
    /**
     ** 文字列 s から作成します.
     ** base は進法です.
     **/
    @safe this(string s, int base = 10)
    {
      __gmpz_init_set_str(&z, s.toStringz, base);
    }
    /**
     ** 文字列に変換した値を返します.
     ** base は進法です.
     **/
    @trusted string toString(int base = 10) const
    {
      auto sz = __gmpz_sizeinbase(&z, base);
      auto buf = new char[](sz + 2);
      __gmpz_get_str(buf.ptr, base, &z);
      return buf.ptr.fromStringz.to!string;
    }
  }

  /**
   ** 値を f に出力します.
   ** base は進法です.
   **/
  size_t fprint(File f, int base = 10) const
  {
    return __gmpz_out_str(f.getFP, base, &z);
  }

  private
  {
    import std.stdio : File;
    __mpz_struct z;
  }
}

extern(C) pragma(inline, false)
{
  import core.stdc.stdio : FILE;
  alias __mp_limb_t = ulong;

  struct __mpz_struct
  {
    int _mp_alloc;
    int _mp_size;
    __mp_limb_t* _mp_d;
  }

  alias mpz_srcptr = const(__mpz_struct)*;
  alias mpz_ptr = __mpz_struct*;

  pure nothrow @nogc @safe
  {
    void __gmpz_init(mpz_ptr);
    void __gmpz_clear(mpz_ptr);

    void __gmpz_init_set(mpz_ptr, mpz_srcptr);
    void __gmpz_init_set_si(mpz_ptr, long);
    int __gmpz_init_set_str(mpz_ptr, const char*, int);

    void __gmpz_set(mpz_ptr, mpz_srcptr);
    void __gmpz_set_si(mpz_ptr, long);

    long __gmpz_get_si(mpz_srcptr);
    char *__gmpz_get_str(char*, int, mpz_srcptr);
    size_t __gmpz_sizeinbase(mpz_srcptr, int);

    size_t __gmpz_out_str(FILE*, int, mpz_srcptr);

    int __gmpz_cmp(mpz_srcptr, mpz_srcptr);
    int __gmpz_cmp_si(mpz_srcptr, long);

    void __gmpz_add(mpz_ptr, mpz_srcptr, mpz_srcptr);
    void __gmpz_add_ui(mpz_ptr, mpz_srcptr, ulong);
    void __gmpz_sub(mpz_ptr, mpz_srcptr, mpz_srcptr);
    void __gmpz_sub_ui(mpz_ptr, mpz_srcptr, ulong);
    void __gmpz_mul(mpz_ptr, mpz_srcptr, mpz_srcptr);
    void __gmpz_mul_ui(mpz_ptr, mpz_srcptr, ulong);
    void __gmpz_tdiv_q(mpz_ptr, mpz_srcptr, mpz_srcptr);
    void __gmpz_tdiv_r(mpz_ptr, mpz_srcptr, mpz_srcptr);
    ulong __gmpz_tdiv_q_ui(mpz_ptr, mpz_srcptr, ulong);
    ulong __gmpz_tdiv_r_ui(mpz_ptr, mpz_srcptr, ulong);
    void __gmpz_pow_ui(mpz_ptr, mpz_srcptr, ulong);

    void __gmpz_abs(mpz_ptr, mpz_srcptr);
    void __gmpz_sqrt(mpz_ptr, mpz_srcptr);
    size_t __gmpz_popcount(mpz_srcptr);
    int __gmpz_probab_prime_p(mpz_srcptr, int reps);
  }
}
pragma(lib, "gmp");
// ::::::::::::::::::::

unittest
{
  auto a = GmpInt(150), b = GmpInt("45");
  assert(a.toLong == 150);
  assert(a.toString == "150");
  assert(b.toLong == 45);
  assert(b.toString == "45");

  assert(a == GmpInt(150));
  assert(a == 150);
  assert(a != GmpInt(149));
  assert(a != 149);

  assert(a >= GmpInt(150));
  assert(a <= GmpInt(150));
  assert(a < GmpInt(160));
  assert(a > GmpInt(140));

  assert(a >= 150);
  assert(a <= 150);
  assert(a < 160);
  assert(a > 140);

  assert(a+b == 195);
  assert(a-b == 105);
  assert(a*b == 6750);
  assert(a/b == 3);
  assert(a%b == 15);

  a = 150; a += b;
  assert(a == 195);
  a = 150; a -= b;
  assert(a == 105);
  a = 150; a *= b;
  assert(a == 6750);
  a = 150; a /= b;
  assert(a == 3);
  a = 150; a %= b;
  assert(a == 15);

  auto c = 35;
  a = 150;

  assert(a+c == 185);
  assert(a-c == 115);
  assert(a*c == 5250);
  assert(a/c == 4);
  assert(a%c == 10);
  assert(a^^3 == 3_375_000);

  a = 150; a += c;
  assert(a == 185);
  a = 150; a -= c;
  assert(a == 115);
  a = 150; a *= c;
  assert(a == 5250);
  a = 150; a /= c;
  assert(a == 4);
  a = 150; a %= c;
  assert(a == 10);
  a = 150; a ^^= 3;
  assert(a == 3_375_000);

  a = 150;
  assert(a.abs == 150);
  assert(a.sqrt == 12);
  assert(a.popcnt == 4);

  assert(!GmpInt(150).probabPrime);
  assert(GmpInt(97).probabPrime);

  auto d = GmpInt(a); d += 10;
  assert(a == 150);
  assert(d == 160);
}
