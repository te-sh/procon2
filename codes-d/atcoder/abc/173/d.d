// URL: https://atcoder.jp/contests/abc173/tasks/abc173_d

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  A.sort!"a>b"();

  auto q = DList!int(A[0]), r = 0L;
  foreach (Ai; A[1..$]) {
    auto a = q.front; q.removeFront();
    r += a;
    q.insertBack(Ai);
    q.insertBack(Ai);
  }

  io.put(r);
}

auto io = IO!()();
import lib.io;
