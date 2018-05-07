// URL: https://beta.atcoder.jp/contests/abc096/tasks/abc096_c

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int h, w; readV(h, w);
  string[] s; readC(h, s);

  auto b = new int[][](h+2, w+2);
  foreach (i; 0..h)
    foreach (j; 0..w)
      b[i+1][j+1] = s[i][j] == '#';

  foreach (i; 1..h+1)
    foreach (j; 1..w+1) {
      if (!b[i][j]) continue;
      auto r = b[i-1][j]+b[i+1][j]+b[i][j-1]+b[i][j+1];
      if (r == 0) {
        writeln("No");
        return;
      }
    }

  writeln("Yes");
}
