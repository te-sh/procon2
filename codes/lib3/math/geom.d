struct Point(T, T eps = 1e-10L)
{
  import std.math;
  T x, y;
  auto isNaN() { return x.isNaN || y.isNaN; }
}

struct Line(T, T eps = 1e-10L)
{
  import std.math;
  T a, b, c;
  auto isNaN() { return a.isNaN || b.isNaN || c.isNaN; }
}

pure Line!(T, eps) line(T, alias eps)(Point!(T, eps) p1, Point!(T, eps) p2)
{
  auto x = p2.x-p1.x;
  auto y = p2.y-p1.y;
  return Line!(T, eps)(y, -x, p2.y*x-p2.x*y);
}

pure T dist(T, alias eps)(Point!(T, eps) p1, Point!(T, eps) p2)
{
  import std.math;
  return ((p1.x-p2.x)^^2 + (p1.y-p2.y)^^2).sqrt;
}

pure T dist(T, alias eps1, alias eps2)(Point!(T, eps1) p, Line!(T, eps2) l)
{
  import std.math;
  return (l.a*p.x + l.b*p.y + l.c).abs / (l.a^^2 + l.b^^2).sqrt;
}

pure Point!(T, eps) intersect(T, alias eps)(Line!(T, eps) l1, Line!(T, eps) l2)
{
  import std.math;
  auto det = l1.a*l2.b - l1.b*l2.a;
  if (approxEqual(det, 0, eps)) return Point!(T, eps)(T.nan, T.nan);
  auto x = (l1.b*l2.c - l2.b*l1.c) / det;
  auto y = (l2.a*l1.c - l1.a*l2.c) / det;
  return Point!(T, eps)(x, y);
}

pure Line!(T, eps) bisector(T, alias eps)(Point!(T, eps) p1, Point!(T, eps) p2)
{
  import std.math;
  auto a = p2.x-p1.x;
  auto b = p2.y-p1.y;
  auto c = (p1.x^^2 - p2.x^^2 + p1.y^^2 - p2.y^^2) / 2;
  if (approxEqual(a, 0, eps) && approxEqual(b, 0, eps)) return Line!(T, eps)(T.nan, T.nan, T.nan);
  return Line!(T, eps)(a, b, c);
}

pure Line!(T, eps)[] bisector(T, alias eps)(Line!(T, eps) l1, Line!(T, eps) l2)
{
  import std.math;
  auto d1 = (l1.a^^2 + l1.b^^2).sqrt;
  auto d2 = (l2.a^^2 + l2.b^^2).sqrt;

  Line!(T, eps)[] r;

  auto a3 = l1.a*d2 - l2.a*d1;
  auto b3 = l1.b*d2 - l2.b*d1;
  auto c3 = l1.c*d2 - l2.c*d1;
  if (!approxEqual(a3, 0, eps) || !approxEqual(b3, 0, eps)) r ~= Line!(T, eps)(a3, b3, c3);

  auto a4 = l1.a*d2 + l2.a*d1;
  auto b4 = l1.b*d2 + l2.b*d1;
  auto c4 = l1.c*d2 + l2.c*d1;
  if (!approxEqual(a4, 0, eps) || !approxEqual(b4, 0, eps)) r ~= Line!(T, eps)(a4, b4, c4);

  return r;
}

/*

  struct Point(T, T eps = 1e-10L)

    点 (x, y) を表します.
    eps は同一性判断に使用します.

  struct Line(T, T eps = 1e-10L)

    直線 ax+by+c=0 を表します.
    eps は同一性判断に使用します.

  pure Line!(T, eps) line(T, alias eps)(Point!(T, eps) p1, Point!(T, eps) p2)

    点 p1, p2 を通る直線を返します.

  pure T dist(T, alias eps)(Point!(T, eps) p1, Point!(T, eps) p2)

    点 p1, p2 の距離を返します.

  pure T dist(T, alias eps1, alias eps2)(Point!(T, eps1) p, Line!(T, eps2) l)

    点 p と直線 l の距離を返します.

  pure Point!(T, eps) intersect(T, alias eps)(Line!(T, eps) l1, Line!(T, eps) l2)

    直線 l1, l2 の交点を返します.
    l1, l2 が平行とみなされる場合は (x, y) = (nan, nan) を返します.

  pure Line!(T, eps) bisector(T, alias eps)(Point!(T, eps) p1, Point!(T, eps) p2)

    点 p1, p2 の垂直二等分線を返します.
    p1, p2 が同一点とみなされる場合は (a, b, c) = (nan, nan, nan) を返します.

  pure Line!(T, eps)[] bisector(T, alias eps)(Line!(T, eps) l1, Line!(T, eps) l2)

    直線 l1, l2 の角の二等分線を配列で返します.
    l1, l2 が平行とみなされる場合は1つだけを返します.

 */

unittest
{
  import std.math;
  auto eps = 1e-10L;
  alias P = Point!double, L = Line!double;

  assert(approxEqual(dist(P(0, 0), P(3, 4)), 5, eps));
  assert(approxEqual(dist(P(0, 0), L(3, -4, -2)), 0.4, eps));

  auto r1 = intersect(L(1, -1, 3), L(2, 1, -6));
  assert(approxEqual(r1.x, 1, eps));
  assert(approxEqual(r1.y, 4, eps));

  assert(intersect(L(1, 1, 0), L(2, 2, 0)).isNaN);

  auto r2 = bisector(P(1, 3), P(5, 1));
  assert(approxEqual(r2.c/r2.a, -2, eps));
  assert(approxEqual(r2.c/r2.b, 4, eps));

  assert(bisector(P(1, 1), P(1, 1)).isNaN);

  auto r3 = bisector(L(2, -1, -3), L(1, -2, 0));
  assert(approxEqual(r3[0].c/r3[0].a, -3, eps));
  assert(approxEqual(r3[0].c/r3[0].b, -3, eps));
  assert(approxEqual(r3[1].c/r3[1].a, -1, eps));
  assert(approxEqual(r3[1].c/r3[1].b, 1, eps));

  auto r4 = bisector(L(1, 1, 0), L(2, 2, 0));
  assert(approxEqual(r4[0].c/r4[0].a, 0, eps));
  assert(approxEqual(r4[0].c/r4[0].b, 0, eps));
}
