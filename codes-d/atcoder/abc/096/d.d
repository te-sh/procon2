// URL: https://atcoder.jp/contests/abc096/tasks/abc096_d

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

  auto p = primes(55555);
  writeA(n, p.filter!(pi => pi%5 == 1).take(n));
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
  T m = T(1) << (n.bsr/2+1);
  return iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
}
