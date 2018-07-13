// URL: https://yukicoder.me/problems/no/174

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
  int n; real pa, pb; readV(n, pa, pb);
  int[] a; readA(n, a);
  int[] b; readA(n, b);

  a.sort();
  b.sort();

  auto calc(int[] a, real p)
  {
    auto q = new real[][](n, n);
    foreach (i; 0..n) q[i][] = 0;

    auto r = new real[](1<<n);
    r[] = 0; r[$-1] = 1;

    foreach_reverse (i; 1..1<<n) {
      auto c = i.popcnt, f = i.bsf;
      if (c == 1) {
        q[c-1][f] += r[i];
      } else {
        auto d = r[i]*p;
        q[c-1][f] += d;
        r[i.bitReset(f)] += d;
        foreach (j; f+1..n)
          if (i.bitTest(j)) {
            d = r[i]*(1-p)/(c-1);
            q[c-1][j] += d;
            r[i.bitReset(j)] += d;
          }
      }
    }

    return q;
  }

  auto r1 = calc(a, pa), r2 = calc(b, pb), e = 0.0L;

  foreach (i; 0..n)
    foreach (j; 0..n)
      foreach (k; 0..n)
        if (a[j] > b[k])
          e += r1[i][j]*r2[i][k]*(a[j]+b[k]);

  writefln("%.10f", e);
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
