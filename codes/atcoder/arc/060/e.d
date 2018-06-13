// URL: https://beta.atcoder.jp/contests/arc060/tasks/arc060_c

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
  int[] x; readA(n, x);
  int l; readV(l);

  auto m = (n-1).bsr+2;

  auto y = new int[](n);
  foreach (i; 0..n) y[n-i-1] = -x[i];

  auto build(int[] x)
  {
    auto s = new int[][](n, m);

    foreach (j; 0..m)
      s[n-1][j] = n-1;

    foreach_reverse (i; 0..n-1) {
      s[i][0] = x.assumeSorted.lowerBound(x[i]+l+1).length.to!int-1;
      foreach (j; 1..m)
        s[i][j] = s[s[i][j-1]][j-1];
    }

    return s;
  }

  auto s1 = build(x), s2 = build(y);

  auto calc(int[][] s, int a, int b)
  {
    auto c = a, r = 0;
    while (c < b) {
      auto t = s[c].assumeSorted.lowerBound(b);
      if (t.empty) {
        ++r;
        break;
      } else {
        r += (1<<(t.length-1));
        c = t.back;
      }
    }
    return r;
  }

  int q; readV(q);
  foreach (_; 0..q) {
    int a, b; readV(a, b); --a; --b;
    if (a < b)
      writeln(calc(s1, a, b));
    else
      writeln(calc(s2, n-a-1, n-b-1));
  }
}

pragma(inline) {
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }

  pure T bitSet(T)(T n, size_t s, size_t e) { return n | ((T(1) << e) - 1) & ~((T(1) << s) - 1); }
  pure T bitReset(T)(T n, size_t s, size_t e) { return n & (~((T(1) << e) - 1) | ((T(1) << s) - 1)); }
  pure T bitComp(T)(T n, size_t s, size_t e) { return n ^ ((T(1) << e) - 1) & ~((T(1) << s) - 1); }

  import core.bitop;
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
  pure int popcnt(T)(T n) { return core.bitop.popcnt(ulong(n)); }
}
