// URL: https://atcoder.jp/contests/abc128/tasks/abc128_f

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
  int n; readV(n);
  int[] s; readA(n, s);

  auto p = Prime(n.nsqrt);

  auto cl = new long[][](n);
  foreach (i; 1..n) {
    for (auto j = 0; j < n; j += i)
      cl[i] ~= s[j];
    foreach (j; 1..cl[i].length) cl[i][j] += cl[i][j-1];
  }
  

  auto cr = new long[][](n);
  foreach (i; 1..n) {
    for (auto j = n-1; j >= 0; j -= i)
      cr[i] ~= s[j];
    foreach (j; 1..cr[i].length) cr[i][j] += cr[i][j-1];
  }

  auto r = 0L;
  foreach (a; 2..n-1) {
    auto d = p.divisors(n-a-1);
    foreach (di; d) {
      auto b = a-(n-a-1)/di;
      if (b < 0) continue;
      auto c = a-b;

      auto k = (n-a-1)/c;
      if (a%c == 0 && k >= a/c) continue;
      r = max(r, cl[c][k]+cr[c][k]);
    }
  }

  writeln(r);
}

struct Prime
{
  import std.algorithm, std.bitmanip, std.math, std.range, std.typecons;
  alias Factor = Tuple!(int, size_t);

  int n;
  int[] primes;
  alias primes this;

  this(int n)
  {
    this.n = n;

    auto sieve = BitArray();
    sieve.length((n+1)/2);
    sieve = ~sieve;

    foreach (p; 1..((nsqrt(n)-1)/2+1))
      if (sieve[p])
        for (auto q = p*3+1; q < (n+1)/2; q += p*2+1)
          sieve[q] = false;

    primes = sieve.bitsSet.map!(p => cast(int)p*2+1).array;
    primes[0] = 2;
  }

  pure auto div(int x)
  in { assert(x > 0 && nsqrt(x) <= n); }
  body {
    Factor[] factors;
    auto t = nsqrt(x);
    foreach (p; primes) {
      if (p > t) {
        factors ~= Factor(x, 1);
        break;
      }
      auto c = size_t(0);
      for (; x%p == 0; x /= p) ++c;
      if (c > 0) factors ~= Factor(p, c);
      if (x == 1) break;
    }
    return factors;
  }

  pure auto divisors(int x)
  {
    auto factors = div(x);
    auto r = divisorsProc(factors, 0, 1);
    r.sort();
    return r;
  }

  pure int[] divisorsProc(Factor[] factors, size_t i, int c)
  {
    if (i == factors.length) return [c];
    int[] r;
    foreach (j; 0..factors[i][1]+1)
      r ~= divisorsProc(factors, i+1, c*factors[i][0]^^cast(int)j);
    return r;
  }

  pure auto nsqrt(int n)
  {
    if (n <= 1) return n;
    auto m = 1<<(n.ilogb/2+1);
    return cast(int)iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length;
  }
}

pure auto nsqrt(T)(T n)
{
  import std.algorithm, std.conv, std.math, std.range;
  if (n <= 1) return n;
  T m = T(1) << (n.ilogb/2+1);
  return iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
}
