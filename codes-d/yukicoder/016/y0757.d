// URL: https://yukicoder.me/problems/no/757

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int B; io.getV(B);
  string s; io.getV(s);

  if (s == "1") io.put!"{exit: true}"(1);

  auto D = GmpInt(s, B)-1;

  auto len(int x)
  {
    auto bp = GmpInt(B)^^x;
    return bp*x - (bp-1)/(B-1);
  }

  auto f = iota(0, cast(int)s.length+1).lowerBoundBy!(x => len(x))(D).back;
  D -= len(f++);

  auto g = D/f + GmpInt(B)^^(f-1), h = D%GmpInt(f);
  io.put(g.toString(B)[h.toLong]);
}

import lib.bound_by;

import lib.math.gmp_int;

auto io = IO!()();
import lib.io;
