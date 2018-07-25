// URL: https://beta.atcoder.jp/contests/arc041/tasks/arc041_c

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
  int n, l; readV(n, l);
  struct R { int x; string d; }
  R[] r; readS(n, r);

  r = [R(-1, "R"), R(0, "L")] ~ r ~ [R(l+1, "R"), R(l+2, "L")];

  auto calc(R[] r, R[] l)
  {
    r.reverse();

    auto j = 0L;
    foreach (i, ri; r) j += r[0].x-i-ri.x;
    foreach (i, li; l) j += li.x-l[0].x-i;
    j += (l[0].x-r[0].x-1) * max(l.length, r.length);

    return j;
  }

  auto j = 0L;
  foreach (ri; r.chunkBy!"a.d == b.d".chunks(2)) {
    auto ria = ri.array;
    j += calc(ria[0].array, ria[1].array);
  }

  writeln(j);
}
