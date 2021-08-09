// URL: https://yukicoder.me/problems/no/303

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int L; io.getV(L);

  if (L == 2) { io.put(3); io.put!"{exit: true}"("INF"); }

  auto calc(int n)
  {
    auto m = Matrix!GmpInt([[1, 1], [1, 0]]);
    return (m^^(n-2))[0].sum;
  }

  io.put(L);
  io.put(calc(L) - (L%2 == 0 ? calc(L/2)^^2 : GmpInt(0)));
}

import lib.math.gmp_int;

import lib.math.matrix;

auto io = IO!()();
import lib.io;
