struct GmpInt
{
  import std.conv;

  __mpz_struct z;

  @property value() { return toLong(); }
  @property value(long v) { __gmpz_set_si(&z, v); }
  alias value this;

  this(long v)
  {
    __gmpz_init(&z);
    __gmpz_set_si(&z, v);
  }

  this(string s, int base = 10)
  {
    import std.string;
    __gmpz_init(&z);
    __gmpz_set_str(&z, s.toStringz, base);
  }

  long toLong() { return __gmpz_get_si(&z); }

  string toString(int base = 10)
  {
    import std.string;
    auto sz = __gmpz_sizeinbase(&z, base);
    auto buf = new char[](sz + 2);
    __gmpz_get_str(buf.ptr, base, &z);
    return buf.ptr.fromStringz.to!string;
  }

  bool opEquals(GmpInt v) { return __gmpz_cmp(&z, &v.z) == 0; }
  bool opEquals(long v) { return __gmpz_cmp_ui(&z, v) == 0; }
  int opCmp(GmpInt v) { return __gmpz_cmp(&z, &v.z); }
  int opCmp(long v) { return __gmpz_cmp_ui(&z, v); }

  GmpInt opAssign(long v) { __gmpz_set_si(&z, v); return this; }

  GmpInt opBinary(string op)(GmpInt v) if (op=="+"||op=="-"||op=="*"||op=="/"||op=="%")
  {
    auto r = GmpInt(0);
    static if (op == "+") __gmpz_add(&r.z, &z, &v.z);
    else   if (op == "-") __gmpz_sub(&r.z, &z, &v.z);
    else   if (op == "*") __gmpz_mul(&r.z, &z, &v.z);
    else   if (op == "/") __gmpz_tdiv_q(&r.z, &z, &v.z);
    else   if (op == "%") __gmpz_mod(&r.z, &z, &v.z);
    return r;
  }

  GmpInt opBinary(string op)(ulong v) if (op=="+"||op=="-"||op=="*"||op=="/"||op=="^^")
  {
    auto r = GmpInt(0);
    static if (op == "+") __gmpz_add_ui(&r.z, &z, v);
    else   if (op == "-") __gmpz_sub_ui(&r.z, &z, v);
    else   if (op == "*") __gmpz_mul_ui(&r.z, &z, v);
    else   if (op == "/") __gmpz_tdiv_q_ui(&r.z, &z, v);
    else   if (op == "^^") __gmpz_pow_ui(&r.z, &z, v);
    return r;
  }

  ref GmpInt opOpAssign(string op)(GmpInt v) if (op=="+"||op=="-"||op=="*"||op=="/"||op=="%")
  {
    static if (op == "+") __gmpz_add(&z, &z, &v.z);
    else   if (op == "-") __gmpz_sub(&z, &z, &v.z);
    else   if (op == "*") __gmpz_mul(&z, &z, &v.z);
    else   if (op == "/") __gmpz_tdiv_q(&z, &z, &v.z);
    else   if (op == "%") __gmpz_mod(&z, &z, &v.z);
    return this;
  }

  ref GmpInt opOpAssign(string op)(ulong v) if (op=="+"||op=="-"||op=="*"||op=="/"||op=="^^")
  {
    static if (op == "+") __gmpz_add_ui(&z, &z, v);
    else   if (op == "-") __gmpz_sub_ui(&z, &z, v);
    else   if (op == "*") __gmpz_mul_ui(&z, &z, v);
    else   if (op == "/") __gmpz_tdiv_q_ui(&z, &z, v);
    else   if (op == "^^") __gmpz_pow_ui(&z, &z, v);
    return this;
  }

  GmpInt sqrt()
  {
    auto r = GmpInt(0);
    __gmpz_sqrt(&r.z, &z);
    return r;
  }

  size_t popcnt()
  {
    return __gmpz_popcount(&z);
  }

  int probabPrime(int reps = 20)
  {
    return __gmpz_probab_prime_p(&z, reps) != 0;
  }
}

extern(C) pragma(inline, false)
{
  alias __mp_limb_t = ulong;

  struct __mpz_struct
  {
    int _mp_alloc;
    int _mp_size;
    __mp_limb_t* _mp_d;
  }

  alias mpz_srcptr = const(__mpz_struct)*;
  alias mpz_ptr = __mpz_struct*;

  void __gmpz_init(mpz_ptr);

  void __gmpz_set_si(mpz_ptr, long);
  int __gmpz_set_str(mpz_ptr, const char*, int);

  long __gmpz_get_si(mpz_srcptr);
  char *__gmpz_get_str(char*, int, mpz_srcptr);
  size_t __gmpz_sizeinbase(mpz_srcptr, int);

  int __gmpz_cmp(mpz_srcptr, mpz_srcptr);
  int __gmpz_cmp_ui(mpz_srcptr, ulong);

  void __gmpz_add(mpz_ptr, mpz_srcptr, mpz_srcptr);
  void __gmpz_add_ui(mpz_ptr, mpz_srcptr, ulong);
  void __gmpz_sub(mpz_ptr, mpz_srcptr, mpz_srcptr);
  void __gmpz_sub_ui(mpz_ptr, mpz_srcptr, ulong);
  void __gmpz_mul(mpz_ptr, mpz_srcptr, mpz_srcptr);
  void __gmpz_mul_ui(mpz_ptr, mpz_srcptr, ulong);
  void __gmpz_tdiv_q(mpz_ptr, mpz_srcptr, mpz_srcptr);
  ulong __gmpz_tdiv_q_ui(mpz_ptr, mpz_srcptr, ulong);
  void __gmpz_mod(mpz_ptr, mpz_srcptr, mpz_srcptr);
  void __gmpz_pow_ui(mpz_ptr, mpz_srcptr, ulong);

  void __gmpz_sqrt(mpz_ptr, mpz_srcptr);
  size_t __gmpz_popcount(mpz_srcptr);
  int __gmpz_probab_prime_p(mpz_ptr, int reps);
}
pragma(lib, "gmp");

/*

  struct GmpInt

    GMP のラッパです.

    GmpInt(long v)

      long の v から GmpInt を作成します.

    GmpInt(string s, int base = 10)

      string の s から GmpInt を作成します.
      base に進法を指定します.

    long toLong()

      long に変換します.

    string toString(int base = 10)

      string に変換します.
      base に進法を指定します.

    a == b
    a != b
    a >= b
    a <= b
    a > b
    a < b

      a と b を比較します.
      b は GmpInt か long を取ります.

    a + b
    a - b
    a * b
    a / b

      四則演算の結果を返します.
      b は GmpInt か long を取ります.

    a += b
    a -= b
    a *= b
    a /= b

      四則演算を行います.
      b は GmpInt か long を取ります.

    a % b

      a を b で割った余りを返します.
      b は GmpInt を取ります.

    a %= b

      a を b で割った余りを計算します.
      b は GmpInt を取ります.

    a ^^ b

      a の b 乗を返します.
      b は long を取ります.

    a ^^= b

      a の b 乗を計算します.
      b は long を取ります.

    GmpInt sqrt()

      平方根を返します. 値は切り捨てです.

    size_t popcnt()

      立っているビットの数を返します.

    bool probabPrime(int reps = 10)

      Miller-Rabin 法により素数かどうかを判定して返します.
      reps に試行回数を指定します.

*/

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
  assert(a^^3 == 3375000);

  a = 150; a += c;
  assert(a == 185);
  a = 150; a -= c;
  assert(a == 115);
  a = 150; a *= c;
  assert(a == 5250);
  a = 150; a /= c;
  assert(a == 4);
  a = 150; a ^^= 3;
  assert(a == 3375000);

  a = 150;
  assert(a.sqrt == 12);
  assert(a.popcnt == 4);

  assert(!GmpInt(150).probabPrime);
  assert(GmpInt(97).probabPrime);
}
