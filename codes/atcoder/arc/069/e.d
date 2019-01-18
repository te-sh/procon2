// URL: https://atcoder.jp/contests/arc069/tasks/arc069_c

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
  int[] a; readA(n, a);

  auto b = new long[](n);

  struct P { int v, i; }
  auto p = new P[](n);
  foreach (i; 0..n) p[i] = P(a[i], i);

  auto st = new SegmentTree!(P, (a, b) => a.v == b.v ? (a.i < b.i ? a : b) : (a.v > b.v ? a : b))(p, P(0, 0));
  auto h = heapify(Array!long());

  auto x = st[0..$].i;
  foreach (i; x..n)
    if (a[i] < a[x])
      h.insert(a[i]);

  while (x > 0) {
    auto y = st[0..x].i;
    b[x] = (n-x-h.length).to!long*(a[x]-a[y]);

    while (!h.empty && h.front >= a[y]) {
      b[x] += h.front-a[y];
      h.removeFront();
    }

    foreach (i; y..x)
      if (a[i] < a[y])
        h.insert(a[i]);

    x = y;
  }

  b[0] = (n-h.length).to!long*a[0];
  while (!h.empty) {
    b[0] += h.front;
    h.removeFront();
  }

  foreach (bi; b) writeln(bi);
}

class SegmentTree(T, alias pred = "a + b")
{
  import core.bitop, std.functional;
  alias predFun = binaryFun!pred;

  const size_t n, an;
  T[] buf;
  T unit;

  this(size_t n, T unit = T.init)
  {
    this.n = n;
    this.unit = unit;
    an = n == 1 ? 1 : (1 << ((n-1).bsr + 1));
    buf = new T[](an*2);
    if (T.init != unit) buf[] = unit;
  }

  this(T[] init, T unit = T.init)
  {
    this(init.length, unit);
    buf[an..an+n][] = init[];
    foreach_reverse (i; 1..an)
      buf[i] = predFun(buf[i*2], buf[i*2+1]);
  }

  void opIndexAssign(T val, size_t i)
  {
    buf[i += an] = val;
    while (i /= 2)
      buf[i] = predFun(buf[i*2], buf[i*2+1]);
  }

  pure T opSlice(size_t l, size_t r)
  {
    l += an; r += an;
    T r1 = unit, r2 = unit;
    while (l != r) {
      if (l % 2) r1 = predFun(r1, buf[l++]);
      if (r % 2) r2 = predFun(buf[--r], r2);
      l /= 2; r /= 2;
    }
    return predFun(r1, r2);
  }

  pure T opIndex(size_t i) { return buf[i+an]; }
  pure size_t opDollar() { return n; }
}
