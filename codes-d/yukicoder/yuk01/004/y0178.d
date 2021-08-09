// URL: https://yukicoder.me/problems/no/178

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a, b; io.getC(N, a, b);

  auto x = new long[](N);
  foreach (ref xi, ai, bi; lockstep(x, a, b)) xi = ai+bi*4;

  auto m = x.maxElement;
  x[] = m-x[];

  io.putB(x.any!"a%2==1", -1, x.sum/2);
}

auto io = IO!()();
import lib.io;
