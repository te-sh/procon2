// URL: https://yukicoder.me/problems/no/303

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int L; io.getV(L);

  if (L == 2) { io.put(3); io.put!"{exit: true}"("INF"); }

  auto calc(int n)
  {
    auto m = matrix!GmpInt([[GmpInt(1), GmpInt(1)], [GmpInt(1), GmpInt(0)]]);
    return (m^^n)[0].sum;
  }

  io.put(L);
  io.put(calc(L) - (L%2 == 0 ? calc(L/2)^^2 : 0));
}

import lib.math.gmp_int;

import lib.math.matrix;

auto io = IO!()();
import lib.io;
