// URL: https://yukicoder.me/problems/no/764

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  double[] L; io.getC(N+2, L);

  auto L0 = L[0], Lc = L.cumulativeSum;
  auto Ll = new double[](N+2), Lr = new double[](N+2);
  Ll[1] = L[1];
  foreach (i; 2..N+2) Ll[i] = max(Ll[i-1], L[i]);
  Lr[N+1] = L[N+1];
  foreach_reverse (i; 1..N+1) Lr[i] = max(Lr[i+1], L[i]);

  auto integral(double a, double x)
  {
    if ((a-x).abs < 1e-11) return a^^2*PI/2;
    return x*sqrt(a^^2-x^^2) + a^^2*asin(x/a);
  }

  auto calc(double r1, double r2)
  {
    if (r1+r2 < L0) {
      return 0.0;
    } else if (r1+L0 < r2) {
      return PI*r1^^2;
    } else if (r2+L0 < r1) {
      return PI*r2^^2;
    } else {
      auto x = (L0^^2+r1^^2-r2^^2)/(L0*2);
      return integral(r2, x-L0)-integral(r2, -r2)+integral(r1, r1)-integral(r1, x);
    }
  }

  io.put(0);
  foreach (i; 2..N) {
    auto a = Lc[1..i+1], b = max(2*Ll[i]-a, 0);
    auto c = Lc[i+1..$], d = max(2*Lr[i+1]-c, 0);
    io.put(calc(a, c)-calc(a, d)-calc(b, c)+calc(b, d));
  }
  io.put(0);
}

import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
