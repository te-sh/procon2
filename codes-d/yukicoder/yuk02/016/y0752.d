// URL: https://yukicoder.me/problems/no/752

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long P; int Q; io.getV(P, Q);

  auto maxM = min(P, 10L^^4), maxK = P/(maxM+1);

  auto b = new long[](maxK+1);
  foreach (k; 1..maxK+1)
    b[k] = b[k-1] + P%k;

  auto c = new long[](maxM+2); c[$-1] = b[$-1];
  foreach_reverse (m; 1..maxM+1) {
    auto u = P/(m+1)+1, v = P/m;
    c[m] = c[m+1] + P*(v-u+1) - m*(v*(v+1)-u*(u-1))/2;
  }

  auto calc(long x)
  {
    if (x <= maxK) {
      return b[x];
    } else {
      auto m = P/x, u = P/(m+1)+1;
      return c[m+1] + P*(x-u+1) - m*(x*(x+1)-u*(u-1))/2;
    }
  }

  foreach (_; 0..Q) {
    long L, R; io.getV(L, R);
    io.put(calc(R) - calc(L-1));
  }
}

auto io = IO!()();
import lib.io;
