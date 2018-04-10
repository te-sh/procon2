// URL: https://beta.atcoder.jp/contests/abc084/tasks/abc084_d

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  auto m = 10^^5+1, p = primes(m);
  auto pb = new bool[](m);
  foreach (pi; p) pb[pi] = true;

  auto b = new int[](m);
  foreach (i; 1..m) b[i] = pb[i] && pb[(i+1)/2];
  auto bc = cumulativeSum(b);

  int q; readV(q);
  foreach (_; 0..q) {
    int l, r; readV(l, r);
    writeln(bc[l..r+1]);
  }
}

class CumulativeSum(T)
{
  size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    s[0] = T(0);
    foreach (i; 0..n) s[i+1] = s[i] + a[i];
  }

  T opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  size_t opDollar() { return n; }
}

auto cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }

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
