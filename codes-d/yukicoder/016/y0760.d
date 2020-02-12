// URL: https://yukicoder.me/problems/no/760

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  double xa, ya, ta; io.getV(xa, ya, ta); ta *= PI/180;
  double x11, y11; io.getV(x11, y11);
  double x12, y12; io.getV(x12, y12);
  double x21, y21; io.getV(x21, y21);
  double x22, y22; io.getV(x22, y22);

  auto tb = atan2(y12-y11, x12-x11)-atan2(y22-y21, x22-x21)+ta;
  auto xb = x11-(x21-xa)*cos(tb-ta)+(y21-ya)*sin(tb-ta);
  auto yb = y11-(x21-xa)*sin(tb-ta)-(y21-ya)*cos(tb-ta);
  io.put(xb, yb, tb/PI*180);
}

auto io = IO!()();
import lib.io;
