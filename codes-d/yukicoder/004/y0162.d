// URL: https://yukicoder.me/problems/no/162

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;
import std.regex;

version(unittest) {} else
void main()
{
  int A; io.getV(A); A = 80-A;
  double[] P; io.getA(3, P); P[] /= 100;

  auto n = 14;

  auto p = new double[][](n+1);
  foreach (i; 1..n+1) {
    p[i] = new double[](1<<i);
    auto j2 = (((1<<i)-1)<<1);
    foreach (j; 0..1<<i) {
      auto q = 1.0;
      foreach (k; 0..i) {
        auto r = P[j2.bitTest(k) + j2.bitTest(k+2)];
        q *= j.bitTest(k) ? 1-r : r;
      }
      p[i][j] = q;
    }
  }

  auto c = new int[][](1<<n);
  foreach (i; 1..1<<n) {
    auto d = 0;
    foreach (j; 0..n+1) {
      if (i.bitTest(j)) {
        ++d;
      } else {
        if (d > 0) {
          c[i] ~= d;
          d = 0;
        }
      }
    }
  }

  auto e = new double[][](A+1, n+1);
  foreach (i; 0..n+1) e[0][i] = i;
  foreach (i; 0..A+1) e[i][0] = 0;

  foreach (y; 1..A+1)
    foreach (t; 1..n+1) {
      e[y][t] = 0;
      foreach (i; 1..1<<t)
        e[y][t] += p[t][i] * c[i].map!(ci => e[y-1][ci]).sum;
    }

  io.put(e[A][n]*2);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
