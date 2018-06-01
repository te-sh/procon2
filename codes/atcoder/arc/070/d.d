// URL: https://beta.atcoder.jp/contests/abc056/tasks/arc070_b

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
  int n, k; readV(n, k);
  int[] a; readA(n, a);

  a = a.filter!(ai => ai < k).array;
  a.sort();
  n = a.length.to!int;

  auto calc(R)(R b, int ai)
  {
    auto dp = new bool[](k), dp2 = new bool[](k);
    dp[0] = true;

    foreach (bi; b) {
      dp2[] = dp[];
      dp[bi..$][] |= dp2[0..$-bi][];
    }

    return dp[k-ai..k].any;
  }

  auto bs = iota(0, n).map!(i => calc(chain(a.take(i), a.drop(i+1)), a[i])).assumeSorted;
  writeln(bs.lowerBound(true).length);
}
