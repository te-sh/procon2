// URL: https://yukicoder.me/problems/no/45

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] V; io.getA(N, V);

  auto dpa = new int[](N+1), dpb = new int[](N+1);
  foreach (i, Vi; V) {
    dpa[i+1] = dpb[i]+Vi;
    dpb[i+1] = max(dpa[i], dpb[i]);
  }

  io.put(max(dpa[N], dpb[N]));
}

auto io = IO!()();
import lib.io;
