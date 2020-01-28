// URL: https://yukicoder.me/problems/no/736

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.numeric;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  long[] a; io.getA(N, a);

  auto g = a.reduce!gcd;
  io.put(a.map!(ai => ai/g));
}

auto io = IO!("%.10f", ":")();
import lib.io;
