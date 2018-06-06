// URL: https://beta.atcoder.jp/contests/arc065/tasks/arc065_c

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
  int n, a, b; readV(n, a, b); --a; --b;
  long[] x, y; readC(n, x, y);

  auto d = (x[a]-x[b]).abs + (y[a]-y[b]).abs;

  auto p = new P[](n);
  foreach (i; 0..n) p[i] = P(x[i], y[i], i);

  auto bufr = BufR();
  foreach (i, pi; p)
    if (i != a && i != b)
      bufr.add(pi);

  auto q = DList!int(a, b), vt = new bool[](n);
  vt[a] = vt[b] = true;

  auto operate(R)(R b, long v, long vl, long vr)
  {
    if (v in b) {
      auto r = b[v].upperBound(P(vl-1, 0, 0));
      P[] removed;
      foreach (p; r) {
        if (p.x >= vr) break;
        vt[p.i] = true;
        removed ~= p;
        q.insertBack(p.i);
      }
      foreach (ri; removed) bufr.remove(ri);
    }
  }

  while (!q.empty) {
    auto ui = q.front; q.removeFront;
    auto u = p[ui], ux = u.x, uy = u.y, up = ux+uy, um = ux-uy;

    operate(bufr.pb, up+d, ux, ux+d);
    operate(bufr.mb, um+d, ux+1, ux+d+1);
    operate(bufr.pb, up-d, ux-d+1, ux+1);
    operate(bufr.mb, um-d, ux-d, ux);
  }

  auto count(R)(R b, long v, long vl, long vr)
  {
    if (v !in b) return 0L;
    return b[v].assumeSorted.upperBound(P(vl-1, 0, 0)).lowerBound(P(vr, 0, 0)).length;
  }

  auto bufh = BufH();
  foreach (pi; p) bufh.add(pi);
  bufh.sort();

  auto ans = 0L;
  foreach (i; 0..n)
    if (vt[i]) {
      auto u = p[i], ux = u.x, uy = u.y, up = ux+uy, um = ux-uy;
      ans += count(bufh.pb, up+d, ux, ux+d);
      ans += count(bufh.mb, um+d, ux+1, ux+d+1);
      ans += count(bufh.pb, up-d, ux-d+1, ux+1);
      ans += count(bufh.mb, um-d, ux-d, ux);
    }

  writeln(ans/2);
}

struct P
{
  long x, y;
  int i;

  auto opCmp(P a) const { return x - a.x; }
}

struct BufR
{
  alias RBT = RedBlackTree!P;
  RBT[long] pb, mb;

  auto add(const P p)
  {
    auto vp = p.x+p.y, vm = p.x-p.y;
    if (vp in pb) pb[vp].insert(p);
    else          pb[vp] = new RBT(p);
    if (vm in mb) mb[vm].insert(p);
    else          mb[vm] = new RBT(p);
  }

  auto remove(const P p)
  {
    auto vp = p.x+p.y, vm = p.x-p.y;
    pb[vp].removeKey(p);
    mb[vm].removeKey(p);
  }
}

struct BufH
{
  P[][long] pb, mb;

  auto add(const P p)
  {
    auto vp = p.x+p.y, vm = p.x-p.y;
    pb[vp] ~= p;
    mb[vm] ~= p;
  }

  auto sort()
  {
    foreach (v; pb.byKey) pb[v].sort();
    foreach (v; mb.byKey) mb[v].sort();
  }
}
