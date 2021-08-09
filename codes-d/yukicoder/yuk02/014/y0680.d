// URL: https://yukicoder.me/problems/no/680

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  foreach (i; 1..32)
    if ((N+i).popcnt == i) io.put!"{exit: true}"("YES");

  io.put("NO");
}

import lib.bitop;

auto io = IO!()();
import lib.io;
