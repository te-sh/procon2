// URL: https://yukicoder.me/problems/no/199

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  Point[] p; io.getS!("x", "y")(5, p);
  io.putB(p.convexHull.length == 5, "YES", "NO");
}

alias Point = Point2!int;
import lib.math.point;

import lib.math.convex_hull;

auto io = IO!()();
import lib.io;
