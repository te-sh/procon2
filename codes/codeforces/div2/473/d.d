// URL: http://codeforces.com/contest/959/problem/D

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] a; readA(n, a);

  auto mp = 1_500_000;
  auto p = primes(mp);

  auto f = new int[][](mp);
  foreach (i; 2..mp) {
    auto m = i;
    while (m > 1) {
      auto fi = factor(m, p);
      if (f[i].empty || f[i][$-1] != fi) f[i] ~= fi;
      m /= fi;
    }
  }

  auto b = new int[](n), v = new bool[](mp), mi = -1;
  foreach (i; 0..n) {
    for (auto c = mi == -1 ? a[i] : mi;; ++c) {
      if (f[c].any!(fi => v[fi])) continue;
      b[i] = c;
      foreach (fi; f[c]) v[fi] = true;
      if (mi == -1 && c > a[i])
        mi = 2;
      else if (mi > 1)
        mi = c;
      break;
    }
  }

  foreach (i; 0..n) {
    write(b[i]);
    if (i < n-1) write(" ");
  }
  writeln;
}

pure T[] primes(T)(T n)
{
  import std.algorithm, std.bitmanip, std.conv, std.range;

  auto sieve = BitArray();
  sieve.length((n+1)/2);
  sieve = ~sieve;

  foreach (p; 1..((nsqrt(n)-1)/2+1))
    if (sieve[p])
      for (auto q = p*3+1; q < (n+1)/2; q += p*2+1)
        sieve[q] = false;

  auto r = sieve.bitsSet.map!(to!T).map!("a*2+1").array;
  r[0] = 2;

  return r;
}

pure T factor(T)(T n, const T[] p)
{
  auto ma = nsqrt(n)+1;
  foreach (pi; p)
    if (pi > ma) return n;
    else if (n%pi == 0) return pi;
  return n;
}

pure T nsqrt(T)(T n)
{
  import std.algorithm, std.conv, std.range, core.bitop;
  if (n <= 1) return n;
  T m = 1 << (n.bsr/2+1);
  return iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
}
