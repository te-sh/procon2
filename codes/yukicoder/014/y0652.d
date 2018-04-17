// URL: https://yukicoder.me/problems/no/652

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;
import std.regex;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

version(unittest) {} else
void main()
{
  int a, b; string s; readV(a, b, s);

  auto m = s.matchFirst(r"UTC(\+|-)(\d+)(\.(\d))?");
  auto c = m[1], d = m[2].to!int, e = m[4].empty ? 0 : m[4].to!int;

  a -= 9;
  if (c == "+") {
    a += d;
    b += e*6;
  } else {
    a -= d;
    b -= e*6;
  }

  if (b < 0)  { b += 60; --a; }
  if (b > 59) { b -= 60; ++a; }

  if (a < 0)  { a += 24; }
  if (a > 23) { a -= 24; }

  writefln("%02d:%02d", a, b);
}
