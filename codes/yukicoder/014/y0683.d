// URL: https://yukicoder.me/problems/no/683

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  long a, b; readV(a, b);

  bool[long][long] memo;
  bool calc(long a, long b)
  {
    if (a == 0 || b == 0) return true;
    if (a in memo && b in memo[a]) return memo[a][b];
    if (a%2 == 0 && b > 0)
      if (calc(a/2, b-1)) return memo[a][b] = true;
    if (b%2 == 0 && a > 0)
      if (calc(a-1, b/2)) return memo[a][b] = true;
    return memo[a][b] = false;
  }

  writeln(calc(a, b) ? "Yes" : "No");
}
