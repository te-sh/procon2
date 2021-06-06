// URL: https://atcoder.jp/contests/typical90/tasks/typical90_ab

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  auto W = 1001, a = new int[][](W, W);

  int N; io.getV(N);
  foreach (_; 0..N) {
    int x1, y1, x2, y2; io.getV(x1, y1, x2, y2);
    a[x1][y1] += 1;
    a[x2][y1] -= 1;
    a[x1][y2] -= 1;
    a[x2][y2] += 1;
  }

  foreach (i; 0..W)
    foreach (j; 1..W)
      a[i][j] += a[i][j-1];
  foreach (j; 0..W)
    foreach (i; 1..W)
      a[i][j] += a[i-1][j];

  auto s = new int[](N+1);
  foreach (i; 0..W)
    foreach (j; 0..W)
      s[a[i][j]]++;

  foreach (i; 1..N+1) io.put(s[i]);
}

auto io = IO!()();
import lib.io;
