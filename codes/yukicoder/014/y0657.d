// URL: https://yukicoder.me/problems/no/657

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

const mod = 17;

version(unittest) {} else
void main()
{
  int q; readV(q);
  int[] n; readC(q, n);

  auto mn = max(n.maxElement, 4);
  auto t = new int[](mn+1);
  t[4] = 1;
  foreach (i; 5..mn+1)
    t[i] = (t[i-1]+t[i-2]+t[i-3]+t[i-4])%mod;

  foreach (i; 0..q)
    writeln(t[n[i]]);
}
