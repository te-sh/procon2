// URL: https://yukicoder.me/problems/no/167

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  string N; io.getV(N);
  string M; io.getV(M);

  if (M == "0") io.put!"{exit: true}"(1);

  auto n1 = N[$-1..$].to!int;
  auto m2 = M[$-min(M.length, 2)..$].to!int;
  io.put(n1^^((m2+3)%4+1) % 10);
}

auto io = IO!()();
import lib.io;
