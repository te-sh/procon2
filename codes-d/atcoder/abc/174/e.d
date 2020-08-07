// URL: https://atcoder.jp/contests/abc174/tasks/abc174_e

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  long[] A; io.getA(N, A);

  long minK(long l)
  {
    return A.map!(Ai => cdiv(Ai, l)-1).sum;
  }

  io.put(iota(1, A.maxElement+1).upperBoundBy!(l => minK(l), "a>=b")(K).front);
}

import lib.math.misc;

import lib.bound_by;

auto io = IO!()();
import lib.io;
