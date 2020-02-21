// URL: https://yukicoder.me/problems/no/306

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  double xa, ya; io.getV(xa, ya);
  double xb, yb; io.getV(xb, yb);

  auto a = Point(xa, ya), b = Point(-xb, yb);
  auto l1 = geom.line(a, b), l2 = Line(1, 0, 0);
  io.put(geom.intersect(l1, l2).y);
}

alias geom = Geom!double, Point = geom.Point, Line = geom.Line;
import lib.math.geom;

auto io = IO!()();
import lib.io;
