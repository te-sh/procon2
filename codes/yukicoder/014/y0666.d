// URL: https://yukicoder.me/problems/no/666

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(i;0..n){t[i]=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t)v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}

const mod = 10^^9+7;

void main()
{
  long a, b; readV(a, b);
  writeln(a*b%mod);
}
