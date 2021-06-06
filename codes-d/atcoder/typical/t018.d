// URL: https://atcoder.jp/contests/typical90/tasks/typical90_r

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  double T; io.getV(T);
  double L, X, Y; io.getV(L, X, Y);

  int Q; io.getV(Q);
  foreach (_; 0..Q) {
    double E; io.getV(E);

    auto y = -(L/2)*sin(2*PI*E/T);
    auto z = (L/2)*(1-cos(2*PI*E/T));

    io.put(180*atan2(z, sqrt(X^^2 + (Y-y)^^2))/PI);
  }
}

auto io = IO!()();
import lib.io;
