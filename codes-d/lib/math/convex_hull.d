module lib.math.convex_hull;
import std;

// :::::::::::::::::::: lib.math.convex_hull
import lib.math.point;

pure nothrow @safe
{
  /**
   ** p の凸包を返します.
   **/
  Point2!T[] convexHull(T)(Point2!T[] p)
  {
    p.multiSort!("a.x < b.x", "a.y < b.y");

    Point2!T[] lower;
    foreach (pi; p) {
      while (lower.length >= 2 && cross(lower[$-2]-pi, lower[$-1]-pi) <= 0)
        lower.length -= 1;
      lower ~= pi;
    }

    Point2!T[] upper;
    foreach_reverse (pi; p) {
      while (upper.length >= 2 && cross(upper[$-2]-pi, upper[$-1]-pi) <= 0)
        upper.length -= 1;
      upper ~= pi;
    }

    return (lower.dropBackOne ~ upper.dropBackOne).array;
  }

  /**
   ** 凸包 p の "直径" (最も長い2点間の距離) の2乗を返します.
   **/
  T convexHullDiameter2(T)(Point2!T[] p)
  {
    auto n = p.length;
    size_t ps, pt;
    foreach (i; 1..n) {
      if (p[i].y > p[ps].y) ps = i;
      if (p[i].y < p[pt].y) pt = i;
    }

    auto maxD = (p[ps]-p[pt]).hypot2;
    auto i = ps, j = pt;
    do {
      auto ni = (i+1) % n, nj = (j+1) % n;
      if (cross(p[ni]-p[i], p[nj]-p[j]) < 0)
        i = ni;
      else
        j = nj;
      maxD = max(maxD, (p[i]-p[j]).hypot2);
    } while (i != ps || j != pt);

    return maxD;
  }
}
// ::::::::::::::::::::

unittest
{
  alias point = Point2!int;
  auto p = [ 4.iota.map!(i => point(0, i)).array,
             4.iota.map!(i => point(1, i)).array,
            10.iota.map!(i => point(2, i)).array,
             4.iota.map!(i => point(3, i)).array,
             5.iota.map!(i => point(4, i)).array,
             1.iota.map!(i => point(5, i+1)).array].joiner.array;

  assert(equal(convexHull(p), [point(0, 0), point(4, 0), point(5, 1),
                               point(4, 4), point(2, 9), point(0, 3)]));
  assert(convexHull(p).convexHullDiameter2 == 85);
}
