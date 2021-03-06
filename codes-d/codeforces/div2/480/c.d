// URL: http://codeforces.com/contest/980/problem/C

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
  int n, k; readV(n, k);
  int[] p; readA(n, p);

  auto g = new int[](256); g[] = -1;

  auto calcGroup(int pi)
  {
    if (g[pi] >= 0) return g[pi];
    foreach_reverse (pj; max(0, pi-k+1)..pi) {
      if (g[pj] >= 0) {
        if (pi-g[pj]+1 <= k) {
          g[pj+1..pi+1][] = g[pj];
          return g[pj];
        } else {
          g[pj+1..pi+1][] = pj+1;
          return pj+1;
        }
      }
    }
    auto j = max(0, pi-k+1);
    g[j..pi+1] = j;
    return j;
  }

  foreach (i, pi; p)
    write(calcGroup(pi), " ");
}
