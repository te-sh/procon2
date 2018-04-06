// URL: http://codeforces.com/contest/959/problem/D

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

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
