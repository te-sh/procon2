// URL: https://yukicoder.me/problems/no/23

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int H, A, D; io.getV(H, A, D);

  auto r = cast(double)H;
  foreach (x; 0..cdiv(H, D)+1) {
    auto ed = x*cast(double)3/2;
    auto cd = H-D*x <= 0 ? 0 : cdiv(H-D*x, A);
    r = min(r, ed+cd);
  }

  io.put(r);
}

import lib.math.misc;

auto io = IO!()();
import lib.io;
