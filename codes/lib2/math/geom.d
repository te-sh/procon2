template Geom2(T, T eps = T(10) ^^ (-10))
{
  import std.math;

  struct Point
  {
    T x, y;
    auto isNaN() { return x.isNaN || y.isNaN; }
  }

  struct Line
  {
    T a, b, c;
    auto isNaN() { return a.isNaN || b.isNaN || c.isNaN; }
  }

  auto line(Point p1, Point p2)
  {
    auto x = p2.x-p1.x;
    auto y = p2.y-p1.y;
    return Line(y, -x, p2.y*x-p2.x*y);
  }

  auto dist(Point p1, Point p2)
  {
    return ((p1.x-p2.x)^^2 + (p1.y-p2.y)^^2).sqrt;
  }

  auto dist(Point p, Line l)
  {
    return (l.a*p.x + l.b*p.y + l.c).abs / (l.a^^2 + l.b^^2).sqrt;
  }

  auto intersect(Line l1, Line l2)
  {
    auto det = l1.a*l2.b - l1.b*l2.a;
    if (approxEqual(det, 0, eps)) return Point(T.nan, T.nan);
    auto x = (l1.b*l2.c - l2.b*l1.c) / det;
    auto y = (l2.a*l1.c - l1.a*l2.c) / det;
    return Point(x, y);
  }

  auto bisector(Point p1, Point p2)
  {
    auto a = p2.x-p1.x;
    auto b = p2.y-p1.y;
    auto c = (p1.x^^2 - p2.x^^2 + p1.y^^2 - p2.y^^2) / 2;
    if (approxEqual(a, 0, eps) && approxEqual(b, 0, eps)) return Line(T.nan, T.nan, T.nan);
    return Line(a, b, c);
  }

  auto bisector(Line l1, Line l2)
  {
    auto d1 = (l1.a^^2 + l1.b^^2).sqrt;
    auto d2 = (l2.a^^2 + l2.b^^2).sqrt;

    Line[] r;

    auto a3 = l1.a*d2 - l2.a*d1;
    auto b3 = l1.b*d2 - l2.b*d1;
    auto c3 = l1.c*d2 - l2.c*d1;
    if (!approxEqual(a3, 0, eps) || !approxEqual(b3, 0, eps)) r ~= Line(a3, b3, c3);

    auto a4 = l1.a*d2 + l2.a*d1;
    auto b4 = l1.b*d2 + l2.b*d1;
    auto c4 = l1.c*d2 + l2.c*d1;
    if (!approxEqual(a4, 0, eps) || !approxEqual(b4, 0, eps)) r ~= Line(a4, b4, c4);

    return r;
  }
}

/*

  Geom2!T

    2次元座標上の点と直線に関する処理を集めたものです.
    mixin して使うことを想定しています.

  Point

    点 (x, y) を表す構造体です.

  Line

    直線 ax+by+c=0 を表す構造体です.

  line(p1, p2)

    点 p1, p2 を通る直線である Line を返します.

  dist(p1, p2)

    点 p1, p2 の距離を返します.

  dist(p, l)

    点 p と直線 l の距離を返します.

  intersect(l1, l2)

    直線 l1, l2 の交点となる Point を返します.

  bisect(p1, p2)

    点 p1, p2 の垂直二等分線となる Line を返します.

  bisect(l1, l2)

    直線 l1, l2 の角の二等分線となる Line 2つを配列で返します.

 */

unittest
{
  import std.math;
  mixin Geom2!real;
  auto eps = 1e-10L;

  auto d1 = dist(Point(0, 0), Point(3, 4));
  assert(approxEqual(d1, 5, eps, eps));

  auto d2 = dist(Point(0, 0), Line(3, -4, -2));
  assert(approxEqual(d2, 0.4, eps));

  auto r1 = intersect(Line(1, -1, 3), Line(2, 1, -6));
  assert(approxEqual(r1.x, 1, eps));
  assert(approxEqual(r1.y, 4, eps));

  auto r2 = bisector(Point(1, 3), Point(5, 1));
  assert(approxEqual(r2.c/r2.a, -2, eps));
  assert(approxEqual(r2.c/r2.b, 4, eps));

  auto r3 = bisector(Line(2, -1, -3), Line(1, -2, 0));
  assert(approxEqual(r3[0].c/r3[0].a, -3, eps));
  assert(approxEqual(r3[0].c/r3[0].b, -3, eps));
  assert(approxEqual(r3[1].c/r3[1].a, -1, eps));
  assert(approxEqual(r3[1].c/r3[1].b, 1, eps));
}
