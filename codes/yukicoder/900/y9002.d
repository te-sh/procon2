// URL: https://yukicoder.me/problems/no/9002

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
T[] readArray(T)(size_t n){auto a=new T[](n),r=readln.splitter;foreach(ref v;a){v=r.front.to!T;r.popFront;}return a;}
T[] readArrayM(T)(size_t n){auto a=new T[](n);foreach(ref v;a)v=readln.chomp.to!T;return a;}

version(unittest) {} else
void main()
{
  int n; readV(n);
  foreach (i; 1..n+1) {
    if (i%3 == 0 && i%5 == 0)
      writeln("FizzBuzz");
    else if (i%3 == 0)
      writeln("Fizz");
    else if (i%5 == 0)
      writeln("Buzz");
    else
      writeln(i);
  }
}
