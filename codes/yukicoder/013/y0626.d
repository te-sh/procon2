// URL: https://yukicoder.me/problems/no/626

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
  int n; long tw; readV(n, tw);
  C[] c; readS(n, c);

  c.sort!((a, b) => a.v.to!real/a.w > b.v.to!real/b.w);

  auto p = 0L;

  auto lowerUpper(int i, C s)
  {
    auto u = 0.0L;
    foreach (j; i..n) {
      if (s.w < c[j].w) {
        u = s.v + c[j].v.to!real/c[j].w*s.w;
        break;
      }
      s += c[j];
    }
    return tuple(s.v, max(u.floor.to!long, s.v));
  }

  auto dfs(int i, C s)
  {
    if (i == n) return;

    auto lu = lowerUpper(i, s);
    if (lu[1] < p) return;
    p = max(p, lu[0]);

    dfs(i+1, s);
    if (s.w >= c[i].w) dfs(i+1, s+c[i]);
  }

  dfs(0, C(0, tw));

  writeln(p);
}

struct C
{
  long v, w;
  auto opBinary(string op: "+")(C a) { return C(v+a.v, w-a.w); }
  auto opOpAssign(string op: "+")(C a) { v += a.v; w -= a.w; return this; }
}
