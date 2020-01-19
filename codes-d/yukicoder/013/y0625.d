// URL: https://yukicoder.me/problems/no/625

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
  int n, m; readV(n, m);

  auto p = [m];
  foreach (i; 2..n+1) {
    auto s = p.enumerate.array;
    s.sort!"a[1] == b[1] ? a[0]<b[0] : a[1]<b[1]";
    s = s[0..i/2];
    if (s.map!"a[1]".sum + i/2 > m) {
      p ~= -1;
      continue;
    }

    auto v = new bool[](i-1);
    foreach (si; s) {
      ++p[si[0]];
      v[si[0]] = true;
    }
    foreach (j; 0..i-1)
      if (!v[j]) p[j] = 0;

    p ~= m - p.sum;
  }

  writeA(n, p.retro);
}
