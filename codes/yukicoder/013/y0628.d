// URL: https://yukicoder.me/problems/no/628

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

  int[string] score;
  foreach (_; 0..n) {
    int no; readV(no);
    int m, s; readV(m, s);
    string[] t; readA(m, t);
    foreach (ti; t) score[ti] += s;
  }

  struct TS { string t; int s; }
  TS[] ts;
  foreach (ti; score.byKey) ts ~= TS(ti, score[ti]);
  ts.sort!"a.s == b.s ? a.t < b.t : a.s > b.s";

  foreach (tsi; ts[0..min(ts.length, 10)])
    writeln(tsi.t, " ", tsi.s);
}
