// URL: https://beta.atcoder.jp/contests/arc040/tasks/arc040_c

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
  string[] s; readC(n, s);

  auto b = s.map!(si => si.map!(sij => sij == 'o').array).array;

  auto find()
  {
    foreach (i; 0..n)
      foreach_reverse (j; 0..n)
        if (!b[i][j]) return tuple(i, j);
    return tuple(-1, -1);
  }

  auto paint(int i, int j)
  {
    b[i][0..j+1][] = true;
    if (i < n-1) b[i+1][j..$][] = true;
  }

  auto r = 0;
  for (;;) {
    auto p = find();
    if (p[0] == -1) break;
    paint(p[0], p[1]);
    ++r;
  }

  writeln(r);
}
