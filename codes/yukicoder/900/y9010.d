// URL: https://yukicoder.me/problems/no/9010

import std.algorithm, std.conv, std.range, std.stdio, std.string;
import std.datetime;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
T[] readArray(T)(size_t n){auto a=new T[](n),r=readln.splitter;foreach(ref v;a){v=r.front.to!T;r.popFront;}return a;}
T[] readArrayM(T)(size_t n){auto a=new T[](n);foreach(ref v;a)v=readln.chomp.to!T;return a;}

version(unittest) {} else
void main()
{
  int n; readV(n);
  auto d = Date(n, 1, 1);
  writeln(d.isLeapYear ? "Yes" : "No");
}
