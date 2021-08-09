// URL: https://yukicoder.me/problems/no/678

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, xLB, xRB; io.getV(N, xLB, xRB);

  struct E { int XL, YU, XR, YD, i; bool a; }
  E[] e; io.getS!("XL", "YU", "XR", "YD")(N, e);
  foreach (i, ref ei; e) ei.i = cast(int)i;

  e.sort!"a.YD>b.YD";
  auto a = new int[](1281), ans = 0;
  a[] = 1;

  foreach (ref ei; e) {
    if (ei.XR < xLB || ei.XL > xRB) continue;
    auto l = max(xLB, ei.XL), r = min(xRB, ei.XR);
    if (a[l..r+1].sum) ei.a = true;
    a[l..r+1][] = 0;
  }

  e.sort!"a.i<b.i";

  foreach (ei; e) io.putB(ei.a, 1, 0);
}

auto io = IO!()();
import lib.io;
