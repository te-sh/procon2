// URL: https://atcoder.jp/contests/abc093/tasks/arc094_a

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
  int a, b, c; readV(a, b, c);

  auto dp = new int[][][](60, 60, 60), inf = 10^^9;

  int calc(int a, int b, int c)
  {
    if (a >= 60 || b >= 60 || c >= 60) return inf;
    if (a == b && b == c) return 0;
    if (dp[a][b][c]) return dp[a][b][c];

    return dp[a][b][c] = min(calc(a+1, b+1, c),
                             calc(a+1, b, c+1),
                             calc(a, b+1, c+1),
                             calc(a+2, b, c),
                             calc(a, b+2, c),
                             calc(a, b, c+2)) + 1;
  }

  writeln(calc(a, b, c));
}
