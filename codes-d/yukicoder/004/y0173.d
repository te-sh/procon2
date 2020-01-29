// URL: https://yukicoder.me/problems/no/173

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv, std.random;

const iter = 100_000;

version(unittest) {} else
void main()
{
  int N; real Pa, Pb; io.getV(N, Pa, Pb);
  int[] A; io.getA(N, A);
  int[] B; io.getA(N, B);

  A.sort; B.sort;

  auto calc()
  {
    auto decide(ref int[] a, double p)
    {
      if (a.length == 1) {
        auto r = a[0];
        a = [];
        return r;
      }

      auto q = uniform01;
      if (q < p) {
        auto r = a[0];
        a = a[1..$];
        return r;
      } else {
        auto i = uniform(1, a.length);
        auto r = a[i];
        a = a[0..i] ~ a[i+1..$];
        return r;
      }
    }

    auto a = A.dup, b = B.dup, sa = 0, sb = 0;

    foreach (_; 0..N) {
      auto ca = decide(a, Pa), cb = decide(b, Pb);
      if (ca > cb)      sa += ca+cb;
      else if (ca < cb) sb += ca+cb;
    }

    return sa > sb;
  }

  auto r = 0;
  foreach (_; 0..iter) r += calc;

  io.put(r.to!double/iter);
}

auto io = IO!()();
import lib.io;
