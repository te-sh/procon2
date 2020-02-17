// URL: https://yukicoder.me/problems/no/303

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int L; io.getV(L);

  if (L == 2) { io.put(3); io.put!"{exit: true}"("INF"); }

  io.put(L);
  io.put(calc(L) - (L%2 == 0 ? calc(L/2)^^2 : 0));
}

auto calc(int n)
{
  auto r = GmpInt(1), so = GmpInt(1), se = GmpInt(0);

  foreach (i; 2..n+1) {
    if (i%2 == 0)
      se += (r = so);
    else
      so += (r = se+1);
  }

  return r;
}

import lib.math.gmp_int;

auto io = IO!()();
import lib.io;
