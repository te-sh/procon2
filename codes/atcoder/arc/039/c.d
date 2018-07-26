// URL: https://beta.atcoder.jp/contests/arc039/tasks/arc039_c

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
  int k; readV(k);
  string s; readV(s);

  auto l = new Link(0, 0);
  l.relink();

  foreach (si; s) {
    l = si.predSwitch('L', l.l, 'R', l.r, 'U', l.u, 'D', l.d);
    l.relink();
  }

  writeln(l.x, " ", l.y);
}

class Link
{
  static Link[ulong] map;

  int x, y;
  Link l, r, u, d;

  static p(int x, int y) { return ((cast(uint)x).to!ulong<<32)|(cast(uint)y); }

  this(int x, int y)
  {
    this.x = x;
    this.y = y;
    map[p(x, y)] = this;
  }

  auto relink()
  {
    if (!l) l = get(x-1, y);
    if (!r) r = get(x+1, y);
    if (!u) u = get(x, y+1);
    if (!d) d = get(x, y-1);

    l.r = r;
    r.l = l;
    u.d = d;
    d.u = u;
  }

  auto get(int x, int y)
  {
    auto p = p(x, y);
    if (p !in map)
      return new Link(x, y);
    else
      return map[p];
  }
}
