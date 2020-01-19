// URL: https://yukicoder.me/problems/no/153

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

  auto g = new int[](n+1);
  foreach (i; 2..n+1) {
    auto mex = new bool[](n+1);
    switch (i%2) {
    case 0: mex[0] = true; break;
    case 1: mex[g[i/2]^g[i/2+1]] = true; break;
    default: assert(0);
    }
    switch (i%3) {
    case 0: mex[g[i/3]] = true; break;
    case 1: mex[g[i/3+1]] = true; break;
    case 2: mex[g[i/3]] = true; break;
    default: assert(0);
    }
    g[i] = mex.countUntil(false).to!int;
  }

  writeln(g[n] == 0 ? "B" : "A");
}
