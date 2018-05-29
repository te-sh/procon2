// URL: https://beta.atcoder.jp/contests/abc075/tasks/abc075_d

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, k; readV(n, k);
  int[] x, y; readC(n, x, y);

  auto xc = x.dup.sort().uniq.array, nxc = xc.length.to!int;
  auto yc = y.dup.sort().uniq.array, nyc = yc.length.to!int;

  auto r = 4*10L^^18;
  foreach (i1; 0..nxc-1)
    foreach (i2; i1+1..nxc)
      foreach (j1; 0..nyc-1)
        foreach (j2; j1+1..nyc) {
          auto c = 0;
          foreach (p; 0..n)
            if (xc[i1] <= x[p] && x[p] <= xc[i2] && yc[j1] <= y[p] && y[p] <= yc[j2])
              ++c;
          if (c >= k) r = min(r, (xc[i2]-xc[i1]).to!long * (yc[j2]-yc[j1]));
        }

  writeln(r);
}
