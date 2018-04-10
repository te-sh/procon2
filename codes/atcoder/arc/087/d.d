// URL: https://beta.atcoder.jp/contests/abc082/tasks/arc087_b

import std.algorithm, std.conv, std.range, std.stdio, std.string;
import std.bitmanip;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

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
