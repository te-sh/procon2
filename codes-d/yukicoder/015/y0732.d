// URL: https://yukicoder.me/problems/no/732

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto p = Prime(N*3).array.assumeSorted;
  auto ca = new int[](N*2), cb = new int[](N*2), ans = 0L;

  foreach (b; p.upperBound(2).lowerBound(N+1)) {
    ca[] = 0;
    foreach (c; p.upperBound(b).lowerBound(N+1)) ++ca[b+c];
    foreach (i; 1..N+1) ans += ca[i*2]*cb[i*2];
    foreach (d; p.upperBound(b).lowerBound(b+N*2+1)) ++cb[d-b];
  }

  io.put(ans);
}

import lib.math.prime;

auto io = IO!()();
import lib.io;
