// URL: https://yukicoder.me/problems/no/180

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  struct L { long a, b; }
  L[] l; io.getS!("a", "b")(N, l);
  l.sort!"a.b<b.b";

  auto cht1 = ConvexHullTrick!long(), cht2 = ConvexHullTrick!long();
  foreach (li; l) cht1.add(-li.b, -li.a);
  foreach_reverse (li; l) cht2.add(li.b, li.a);

  auto f(int x) { return -cht1.query(x)-cht2.query(x); }

  io.put(iota(1, int.max).upperBoundBy!(x => f(x+1)-f(x), "a<=b")(0).front);
}

import lib.bound_by;

import lib.math.convex_hull_trick;

auto io = IO!()();
import lib.io;
