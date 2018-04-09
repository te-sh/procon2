// URL: https://yukicoder.me/problems/no/661

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int i; readV(i);
  foreach (_; 0..i) {
    int n; readV(n);
    if (n%8 == 0 && n%10 == 0)
      writeln("ikisugi");
    else if (n%8 == 0)
      writeln("iki");
    else if (n%10 == 0)
      writeln("sugi");
    else
      writeln(n/3);
  }
}