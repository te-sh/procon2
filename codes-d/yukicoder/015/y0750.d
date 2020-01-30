// URL: https://yukicoder.me/problems/no/750

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  struct F { int a, b; }
  F[] f; io.getS!("a", "b")(n, f);

  f.sort!"a.a*b.b>b.a*a.b";

  foreach (fi; f) io.put(fi.a, fi.b);
}

auto io = IO!()();
import lib.io;
