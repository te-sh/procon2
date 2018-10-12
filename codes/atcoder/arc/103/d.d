// URL: https://beta.atcoder.jp/contests/abc111/tasks/arc103_b

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
  int[] x, y; readC(n, x, y);

  auto u = new int[](n), v = new int[](n);
  foreach (i; 0..n) {
    u[i] = x[i] + y[i];
    v[i] = x[i] - y[i];
  }

  auto e = u.all!(ui => ui%2 == 0);
  if (!e && !u.all!(ui => ui%2 != 0)) {
    writeln(-1);
    return;
  }

  if (e) { --u[]; --v[]; }

  auto m = 31;
  if (e) {
    writeln(m+1);
    writeA(m+1, chain([1], iota(m).map!"2^^a"));
  } else {
    writeln(m);
    writeA(m, iota(m).map!"2^^a");
  }

  foreach (i; 0..n) {
    if (e) write('R');
    auto ut = (2^^m-1-u[i])/2, vt = (2^^m-1-v[i])/2;
    foreach (j; 0..m) {
      auto ub = ut.bitTest(j) ? 1 : 0, vb = vt.bitTest(j) ? 1 : 0;
      write(['R', 'U', 'D', 'L'][(ub<<1)|vb]);
    }
    writeln;
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
