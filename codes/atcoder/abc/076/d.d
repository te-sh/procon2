// URL: https://beta.atcoder.jp/contests/abc076/tasks/abc076_d

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

const inf = 10^^9;

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] t; readA(n, t);
  int[] v; readA(n, v);

  t[] *= 2; v[] *= 2;
  foreach (i; 0..n-1) t[i+1] += t[i];
  auto te = t[$-1];

  auto l = [Line(1, 0, 0, te), Line(-1, te, 0, te)];

  foreach (i; 0..n)
    l ~= Line(0, v[i], i == 0 ? 0 : t[i-1], t[i]);

  foreach (i; 0..n-1)
    if (v[i] < v[i+1])
      l ~= Line(1, v[i]-t[i], t[i], te);
    else
      l ~= Line(-1, v[i+1]+t[i], 0, t[i]);

  auto u = new int[](te+1);
  foreach (i; 0..te+1)
    u[i] = l.map!(li => li.v(i)).reduce!min;

  auto r = 0.0L;
  foreach (i; 0..te)
    if      (u[i] < u[i+1]) r += 0.5 + u[i];
    else if (u[i] > u[i+1]) r += 0.5 + u[i+1];
    else                    r += u[i];

  writefln("%.4f", r/4);
}

struct Line
{
  int a, b, ts, te;
  auto v(int t) { return (t < ts || t > te) ? inf : a*t+b; }
}
