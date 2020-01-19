// URL: https://yukicoder.me/problems/no/757

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int b; readV(b);
  string s; readV(s);

  if (s == "1") {
    writeln(1);
    return;
  }

  auto d = GmpInt(s, b)-1;

  auto len(int x)
  {
    auto bp = GmpInt(b)^^x;
    return bp*x - (bp-1)/(b-1);
  }

  auto es = iota(0, s.length.to!int+1).map!(x => tuple(x, len(x))).assumeSorted!"a[1]<b[1]";
  auto e = es.lowerBound(tuple(1, d)).back;
  auto f = e[0]+1;
  d -= e[1];

  auto g = d/f + GmpInt(b)^^(f-1), h = d%GmpInt(f);
  writeln(g.toString(b)[h.toLong]);
}

struct GmpInt
{
  __mpz_struct z;

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

  auto toLong()
  {
    return __gmpz_get_si(&z);
  }

  auto toString(int base = 10)
  {
    import std.string;
    auto sz = __gmpz_sizeinbase(&z, base);
    auto buf = new char[](sz + 2);
    __gmpz_get_str(buf.ptr, base, &z);
    return buf.ptr.fromStringz;
  }

  auto opCmp(GmpInt v)
  {
    return __gmpz_cmp(&z, &v.z);
  }

  auto opBinary(string op)(GmpInt v)
    if (op == "+" || op == "-" || op == "*" || op == "/" || op == "%")
  {
    auto r = GmpInt(0);
    static if (op == "+") __gmpz_add(&r.z, &z, &v.z);
    else   if (op == "-") __gmpz_sub(&r.z, &z, &v.z);
    else   if (op == "*") __gmpz_mul(&r.z, &z, &v.z);
    else   if (op == "/") __gmpz_tdiv_q(&r.z, &z, &v.z);
    else   if (op == "%") __gmpz_mod(&r.z, &z, &v.z);
    return r;
  }

  auto opBinary(string op)(ulong v)
    if (op == "+" || op == "-" || op == "*" || op == "/" || op == "^^")
  {
    auto r = GmpInt(0);
    static if (op == "+") __gmpz_add_ui(&r.z, &z, v);
    else   if (op == "-") __gmpz_sub_ui(&r.z, &z, v);
    else   if (op == "*") __gmpz_mul_ui(&r.z, &z, v);
    else   if (op == "/") __gmpz_tdiv_q_ui(&r.z, &z, v);
    else   if (op == "^^") __gmpz_pow_ui(&r.z, &z, v);
    return r;
  }

  auto opOpAssign(string op)(GmpInt v)
    if (op == "+" || op == "-" || op == "*" || op == "/" || op == "%")
  {
    static if (op == "+") __gmpz_add(&z, &z, &v.z);
    else   if (op == "-") __gmpz_sub(&z, &z, &v.z);
    else   if (op == "*") __gmpz_mul(&z, &z, &v.z);
    else   if (op == "/") __gmpz_tdiv_q(&z, &z, &v.z);
    else   if (op == "%") __gmpz_mod(&z, &z, &v.z);
    return this;
  }

  auto opOpAssign(string op)(ulong v)
    if (op == "+" || op == "-" || op == "*" || op == "/" || op == "^^")
  {
    static if (op == "+") __gmpz_add_ui(&z, &z, v);
    else   if (op == "-") __gmpz_sub_ui(&z, &z, v);
    else   if (op == "*") __gmpz_mul_ui(&z, &z, v);
    else   if (op == "/") __gmpz_tdiv_q_ui(&z, &z, v);
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

  int probabPrime(int reps)
  {
    return __gmpz_probab_prime_p(&z, reps);
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
