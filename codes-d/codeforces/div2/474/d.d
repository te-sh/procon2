// URL: http://codeforces.com/contest/960/problem/D

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
  int q; readV(q);

  auto v = new long[](64), n = new long[](64);

  foreach (_; 0..q) {
    auto rd = rdsp;
    int t; long x; pickV(rd, t, x);
    auto r = x.bsr, r2 = (1L<<r);
    switch (t) {
    case 1:
      long k; pick(rd, k);
      (v[r] += k%r2 + r2) %= r2;
      break;
    case 2:
      long k; pick(rd, k);
      (n[r] += k%r2 + r2) %= r2;
      break;
    case 3:
      auto s = new long[](r+1);
      foreach (i; 1..r+1) s[i] = (s[i-1]*2+n[i])%(1L<<i);

      auto ri = x.bitReset(r)+v[r]+s[r];
      foreach_reverse (i; 0..r+1) {
        auto si = (v[i]+s[i])%(1L<<i);
        auto y = (((1L<<i)-si+ri)%(1L<<i)).bitSet(i);
        write(y);
        if (i > 0) write(" ");
        ri >>= 1;
      }
      writeln;
      break;
    default:
      assert(0);
    }
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
