// URL: https://atcoder.jp/contests/arc066/tasks/arc066_c

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

  auto a = new int[](n), op = new string[](n), rd = rdsp;
  pick(rd, a[0]); op[0] = "+";
  foreach (i; 1..n) pickV(rd, op[i], a[i]);

  auto dp = new long[][](n+1, 3);
  foreach (ref dpi; dp) dpi[] = -10L^^17;
  dp[0][0] = 0;

  foreach (i; 0..n) {
    if (op[i] == "+") {
      auto r0 = dp[i][0]+a[i];
      auto r1 = dp[i][1]-a[i];
      auto r2 = dp[i][2]+a[i];
      dp[i+1][0] = max(r0, r1, r2);
      dp[i+1][1] = max(r1, r2);
      dp[i+1][2] = r2;
    } else {
      auto r1 = max(dp[i][0], dp[i][2])-a[i];
      auto r2 = dp[i][1]+a[i];
      dp[i+1][0] = max(r1, r2);
      dp[i+1][1] = max(r1, r2);
      dp[i+1][2] = r2;
    }
  }

  writeln(dp[$-1][0]);
}
