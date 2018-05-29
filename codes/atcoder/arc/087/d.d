// URL: https://beta.atcoder.jp/contests/abc082/tasks/arc087_b

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
  string s; readV(s);
  int x, y; readV(x, y);

  auto ss = s.split('T').map!(si => si.length.to!int).array;
  int[] u, v;
  foreach (i, si; ss[1..$]) {
    if (i%2 == 0) u ~= si.to!int;
    else          v ~= si.to!int;
  }

  writeln(calc(u, 0, y) && calc(v, ss[0], x) ? "Yes" : "No");
}

auto calc(int[] u, int p0, int pg)
{
  auto ofs = 8010, b = new bool[](ofs*2+1), b2 = new bool[](ofs*2+1);
  b[p0+ofs] = true;
  foreach (ui; u) {
    b2[] = false;
    b2[0..$-ui][] |= b[ui..$][];
    b2[ui..$][] |= b[0..$-ui][];
    b[] = b2[];
  }
  return b[pg+ofs];
}
