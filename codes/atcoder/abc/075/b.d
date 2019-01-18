// URL: https://atcoder.jp/contests/abc075/tasks/abc075_b

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
  dchar[][] s; readC(h, s);

  auto isBakudan(int i, int j)
  {
    if (i < 0 || i >= h || j < 0 || j >= w) return false;
    return s[i][j] == '#';
  }

  foreach (i; 0..h)
    foreach (j; 0..w) {
      if (s[i][j] == '#') continue;
      int r = 0;
      foreach (di; -1..2)
        foreach (dj; -1..2)
          if (di != 0 || dj != 0) r += isBakudan(i+di, j+dj);
      s[i][j] = cast(dchar)('0'+r);
    }

  foreach (si; s) writeln(si);
}
