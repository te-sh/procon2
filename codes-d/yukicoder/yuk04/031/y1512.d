// URL: https://yukicoder.me/problems/no/1512

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string[] S; io.getC(N, S);

  struct C { dchar s, e; int l; }
  C[] c;

  foreach (i, Si; S)
    if (Si.to!(dchar[]).sort.to!string == Si)
      c ~= C(Si[0], Si[$-1], Si.length.to!int);
  c.multiSort!("a.s<b.s", "a.e<b.e");
  auto n = c.length;

  auto dp = new int[][](n+1, 26);
  dp[0][0] = 1;
  foreach (i; 0..n)
    foreach (j; 0..26) {
      dp[i+1][j].maxU(dp[i][j]);
      if (c[i].s-'a' >= j)
        dp[i+1][c[i].e-'a'].maxU(dp[i][j]+c[i].l);
    }

  io.put(dp[$-1].maxElement-1);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
