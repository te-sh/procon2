// URL: https://yukicoder.me/problems/no/716

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a; io.getA(N, a);

  auto b = new int[](N-1);
  foreach (i; 0..N-1) b[i] = a[i+1]-a[i];

  io.put(b.minElement);
  io.put(a[$-1]-a[0]);
}

auto io = IO!()();
import lib.io;
