// URL: https://yukicoder.me/problems/no/707

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
  int h, w; readV(h, w);
  string[] p; readC(h, p);

  auto r = 1.0e+10L;

  auto calc(int x, int y)
  {
    auto s = 0.0L;
    foreach (i; 0..h)
      foreach (j; 0..w)
        if (p[i][j] == '1')
          s += ((i+1-y)^^2+(j+1-x)^^2).to!real.sqrt;

    r = min(r, s);
  }

  foreach (i; 1..h+1) {
    calc(0, i);
    calc(w+1, i);
  }

  foreach (i; 1..w+1) {
    calc(i, 0);
    calc(i, h+1);
  }

  writefln("%.7f", r);
}
