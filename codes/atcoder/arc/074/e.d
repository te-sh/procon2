// URL: https://beta.atcoder.jp/contests/arc074/tasks/arc074_c

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

const mod = 10^^9+7;

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);
  struct C { int l, r, x; }
  C[] c; readS(m, c);

  C[][int] ch;
  foreach (ci; c) ch[ci.r] ~= ci;

  auto dp = new int[][][](n+1, n+1, n+1);
  dp[0][0][0] = 1;

  foreach (r; 0..n+1)
    foreach (g; 0..n+1)
      foreach (b; 0..n+1) {
        auto k = max(r, g, b);

        if (k in ch) {
          foreach (ci; ch[k]) {
            if (r == k) {
              if ((b >= ci.l) + (g >= ci.l) + 1 != ci.x)
                dp[r][g][b] = 0;
            } else if (g == k) {
              if ((r >= ci.l) + (b >= ci.l) + 1 != ci.x)
                dp[r][g][b] = 0;
            } else {
              if ((r >= ci.l) + (g >= ci.l) + 1 != ci.x)
                dp[r][g][b] = 0;
            }
          }
        }

        if (k < n) {
          (dp[k+1][g][b] += dp[r][g][b]) %= mod;
          (dp[r][k+1][b] += dp[r][g][b]) %= mod;
          (dp[r][g][k+1] += dp[r][g][b]) %= mod;
        }
      }

  auto ans = 0;
  foreach (c1; 0..n)
    foreach (c2; 0..n) {
      (ans += dp[n][c1][c2]) %= mod;
      (ans += dp[c1][n][c2]) %= mod;
      (ans += dp[c1][c2][n]) %= mod;
    }

  writeln(ans);
}
