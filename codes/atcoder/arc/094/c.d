// URL: https://beta.atcoder.jp/contests/arc094/tasks

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int a, b, c; readV(a, b, c);

  auto dp = new int[][][](60, 60, 60), inf = 10^^9;

  int calc(int a, int b, int c)
  {
    if (a >= 60 || b >= 60 || c >= 60) return inf;
    if (a == b && b == c) return 0;
    if (dp[a][b][c]) return dp[a][b][c];

    return dp[a][b][c] = min(calc(a+1, b+1, c),
                             calc(a+1, b, c+1),
                             calc(a, b+1, c+1),
                             calc(a+2, b, c),
                             calc(a, b+2, c),
                             calc(a, b, c+2)) + 1;
  }

  writeln(calc(a, b, c));
}
