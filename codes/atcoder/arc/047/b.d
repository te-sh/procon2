// URL: https://beta.atcoder.jp/contests/arc047/tasks/arc047_b

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

const lim = 10^^9;

version(unittest) {} else
void main()
{
  int n; readV(n);
  long[] x, y; readC(n, x, y);

  auto u = new long[](n), v = new long[](n);
  u[] = x[]+y[]; v[] = x[]-y[];

  auto uM = u.reduce!max, um = u.reduce!min, vM = v.reduce!max, vm = v.reduce!min;
  auto r = max(uM-um, vM-vm)/2;

  auto calc(long px, long py)
  {
    if (px < -lim || lim < px || py < -lim || lim < py) return false;

    auto r = (x[0]-px).abs + (y[0]-py).abs;
    foreach (i; 1..n)
      if ((x[i]-px).abs + (y[i]-py).abs != r) return false;

    return true;
  }

  struct P { long u, v; }
  P[] p;

  foreach (b; [P(uM, vM), P(uM, vm), P(um, vM), P(um, vm)]) {
    if (b.u.abs%2 != b.v.abs%2) continue;
    foreach (c; [P(r, r), P(r, -r), P(-r, r), P(-r, -r)]) {
      auto pu = b.u+c.u, pv = b.v+c.v;
      auto px = (pu+pv)/2, py = (pu-pv)/2;
      if (calc(px, py)) {
        writeln(px, " ", py);
        return;
      }
    }
  }
}
