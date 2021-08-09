// URL: https://yukicoder.me/problems/no/627

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int T; io.getV(T);
  int[] X; io.getC(T, X);

  auto calc()
  {
    if (X[0].abs != 1) return false;
    foreach (i; 0..T-1)
      if ((X[i]-X[i+1]).abs != 1) return false;
    return true;
  }

  io.putB(calc, "T", "F");
}

auto io = IO!()();
import lib.io;
