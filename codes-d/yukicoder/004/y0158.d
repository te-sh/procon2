// URL: https://yukicoder.me/problems/no/158

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
  int at, ah, ao; readV(at, ah, ao);
  int db; readV(db);
  int bt, bh, bo; readV(bt, bh, bo);
  int dc; readV(dc);
  int ct, ch, co; readV(ct, ch, co);

  auto a = W(at, ah, ao), b = W(bt, bh, bo), c = W(ct, ch, co);

  auto m = new int[][][](11, 101, 10001);
  foreach (i; 0..11)
    foreach (j; 0..101)
      m[i][j][] = -1;

  int calc(W a)
  {
    if (a.t == -1) return -1;
    if (m[a.t][a.h][a.o] != -1)
      return m[a.t][a.h][a.o];

    auto ab = payAndGet(a, db, b);
    auto ac = payAndGet(a, dc, c);

    return m[a.t][a.h][a.o] = max(calc(ab), calc(ac))+1;
  }

  writeln(calc(a));
}

struct W { int t, h, o; }

auto payAndGet(W a, int p, W g)
{
  auto pt = min(p/1000, a.t);
  a.t -= pt;
  p -= pt*1000;

  auto ph = min(p/100, a.h);
  a.h -= ph;
  p -= ph*100;

  if (p > a.o) return W(-1, -1, -1);

  a.o -= p;

  return W(a.t+g.t, a.h+g.h, a.o+g.o);
}
