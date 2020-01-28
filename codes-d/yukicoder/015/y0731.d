// URL: https://yukicoder.me/problems/no/731

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a; io.getA(N, a);

  auto x = new double[](N), y = new double[](N);
  foreach (i; 0..N) {
    x[i] = i;
    y[i] = a[i];
  }

  auto ax = x.sum/N, ay = y.sum/N;
  x[] -= ax; y[] -= ay;

  auto sxy = 0.0, sx = 0.0;
  foreach (i; 0..N) {
    sxy += x[i]*y[i];
    sx += x[i]^^2;
  }

  auto d = sxy/sx, b = ay-ax*d;

  auto c = 0.0;
  foreach (i; 0..N) c += (d*i+b-a[i])^^2;

  io.put(b, d);
  io.put(c);
}

auto io = IO!()();
import lib.io;
