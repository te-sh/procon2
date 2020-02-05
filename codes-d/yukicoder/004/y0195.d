// URL: https://yukicoder.me/problems/no/195

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long[] X; io.getA(3, X);
  X = X.sort.uniq.array;

  auto n = 41, c = new long[](n), d = new long[](n);
  c[0] = 1; d[0] = 0;

  auto m = matrix([[0, 1], [1, 1]]);
  foreach (i; 1..n) {
    auto mi = m^^(i-1);
    c[i] = mi[1][0]; d[i] = mi[1][1];
  }

  auto r = [10L^^18, 10L^^18];

  if (X.length == 1) {
    if (X[0] == 1) io.put!"{exit: true}"(1, 1);
    auto A = 1L;
    foreach (i; 1..n) {
      auto B = frac(X[0]-A*c[i], d[i]);
      if (B.b == 1 && B.a > 0)
        r = min(r, [A, B.a]);
    }
  } else if (X.length == 2) {
    foreach (i; 0..n)
      foreach (j; i+1..n) {
        auto A = frac(d[j]*X[0]-d[i]*X[1], c[i]*d[j]-d[i]*c[j]);
        auto B = frac(c[i]*X[1]-c[j]*X[0], c[i]*d[j]-d[i]*c[j]);
        if (A.b == 1 && A.a > 0 && B.b == 1 && B.a > 0)
          r = min(r, [A.a, B.a]);
      }
  } else {
    foreach (i; 0..n)
      foreach (j; i+1..n) {
        auto A = frac(d[j]*X[0]-d[i]*X[1], c[i]*d[j]-d[i]*c[j]);
        auto B = frac(c[i]*X[1]-c[j]*X[0], c[i]*d[j]-d[i]*c[j]);
        if (A.b == 1 && A.a > 0 && B.b == 1 && B.a > 0) {
          auto a = A.a, b = B.a;
          foreach (k; j+1..n)
            if (c[k]*a+d[k]*b == X[2])
              r = min(r, [a, b]);
        }
      }
  }

  io.putB(r[0] < 10L^^18 && r[1] < 10L^^18, r, -1);
}

import lib.math.frac;

import lib.math.matrix;

auto io = IO!()();
import lib.io;
