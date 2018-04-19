// URL: https://yukicoder.me/problems/no/670

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

ulong seed;
int next() {
  seed = seed ^ (seed << 13);
  seed = seed ^ (seed >> 7);
  seed = seed ^ (seed << 17);
  return cast(int)(seed >> 33);
}

version(unittest) {} else
void main()
{
  int n, q; readV(n, q, seed);

  foreach (i; 0..10000) next();

  auto a = new int[](n);
  foreach (i; 0..n) a[i] = next();

  auto as = a.sort();

  auto b = new int[](1<<20);
  foreach (ai; a) ++b[ai>>11];
  auto bc = cumulativeSum(b);

  auto ans = 0uL;
  foreach (i; 0..q) {
    auto x = next();
    if (b[x>>11] <= 1)
      ans ^= bc[0..x>>11] * i;
    else
      ans ^= as.lowerBound(x).length.to!ulong * i;
  }

  writeln(ans);
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
