// URL: https://yukicoder.me/problems/no/670

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

ulong seed;
int next() {
  seed = seed ^ (seed << 13);
  seed = seed ^ (seed >> 7);
  seed = seed ^ (seed << 17);
  return cast(int)(seed >> 33);
}

const tb = 31, ub = 20, db = tb-ub;

version(unittest) {} else
void main()
{
  int n, q; readV(n, q, seed);

  foreach (i; 0..10000) next();

  auto a = new int[](n);
  foreach (i; 0..n) a[i] = next();
  a.sort();

  auto b = new int[][](1<<ub);
  foreach (ai; a) b[ai>>db] ~= ai;
  auto c = b.map!(bi => bi.length).array;
  auto cc = new ulong[](1<<ub+1);
  foreach (i; 0..1<<ub) cc[i+1] = cc[i]+c[i];

  auto ans = 0uL;
  foreach (i; 0..q) {
    auto x = next(), xi = (x>>db);
    ans ^= (cc[xi] + b[xi].countUntil!(bi => bi >= x)) * i;
  }

  writeln(ans);
}
