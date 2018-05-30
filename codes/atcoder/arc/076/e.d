// URL: https://beta.atcoder.jp/contests/arc076/tasks/arc076_c

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
  int r, c, n; readV(r, c, n);

  struct P { int s, i; }
  P[] p;

  auto score(int x, int y)
  {
    if (y == 0) return x;
    else if (x == r) return r+y;
    else if (y == c) return r+c+(r-x);
    else if (x == 0) return r+c+r+(c-y);
    return -1;
  }

  foreach (i; 0..n) {
    int x1, y1, x2, y2; readV(x1, y1, x2, y2);
    
    auto s1 = score(x1, y1);
    auto s2 = score(x2, y2);
    if (s1 >= 0 && s2 >= 0) p ~= [P(s1, i), P(s2, i)];
  }

  p.sort!"a.s < b.s";

  auto s = SList!int();
  foreach (pi; p)
    if (!s.empty && s.front == pi.i)
      s.removeFront();
    else
      s.insertFront(pi.i);

  writeln(s.empty ? "YES" : "NO");
}
