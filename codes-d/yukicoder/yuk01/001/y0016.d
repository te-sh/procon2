// URL: https://yukicoder.me/problems/no/16

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int x, N; io.getV(x, N);
  int[] a; io.getA(N, a);

  auto xm = mint(x);
  io.put(a.map!(ai => xm^^ai).sum);
}

const mod = 10^^6+3;
alias mint = ModInt!(mod, true);
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
