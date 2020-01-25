// URL: https://yukicoder.me/problems/no/167

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv;

version(unittest) {} else
void main()
{
  string N; io.getV(N);
  string M; io.getV(M);

  if (M == "0") { io.put(1); return; }

  auto n1 = N[$-1..$].to!int;
  auto m2 = M[$-min(M.length, 2)..$].to!int;
  io.put(n1^^((m2+3)%4+1) % 10);
}

auto io = IO!()();
import lib.io;
