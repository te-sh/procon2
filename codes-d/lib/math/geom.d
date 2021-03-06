module lib.math.geom;
import std;

// :::::::::::::::::::: lib.math.geom
/**
 ** 平面幾何を表します.
 ** eps は同一視する差分の最大値です.
 **/
template Geom(T, T eps = 1e-10)
  if (isFloatingPoint!T)
{
  /**
   ** 点を表します.
   ** eps は同一性判定用の数値です.
   **/
  struct Point
  {
    T x, y;
    auto isNaN() { return x.isNaN || y.isNaN; }
  }

  /**
   ** 直線を表します.
   ** eps は同一性判定用の数値です.
   **/
  struct Line
  {
    T a, b, c;
    auto isNaN() { return a.isNaN || b.isNaN || c.isNaN; }
  }

  pure nothrow @nogc @safe
  {
    /**
     ** 点 p1, p2 を通る直線を返します.
     **/
    Line line(const Point p1, const Point p2)
    {
      auto x = p2.x-p1.x;
      auto y = p2.y-p1.y;
      return Line(y, -x, p2.y*x-p2.x*y);
    }

    /**
     ** 点 p1, p2 の距離を返します.
     **/
    T dist(const Point p1, const Point p2)
    {
      return ((p1.x-p2.x)^^2 + (p1.y-p2.y)^^2).sqrt;
    }

    /**
     ** 点 p, と直線 l の距離を返します.
     **/
    T dist(const Point p, const Line l)
    {
      return (l.a*p.x + l.b*p.y + l.c).abs / (l.a^^2 + l.b^^2).sqrt;
    }

    /**
     ** 直線 l1, l2 の交点を返します.
     ** l1, l2 が平行とみなされる場合は (x, y) = (nan, nan) を返します.
     **/
    Point intersect(const Line l1, const Line l2)
    {
      auto det = l1.a*l2.b - l1.b*l2.a;
      if (approxEqual(det, 0, eps)) return Point(T.nan, T.nan);
      auto x = (l1.b*l2.c - l2.b*l1.c) / det;
      auto y = (l2.a*l1.c - l1.a*l2.c) / det;
      return Point(x, y);
    }

    /**
     ** 点 p1, p2 の垂直二等分線を返します.
     ** p1, p2 が同一点とみなされる場合は (a, b, c) = (nan, nan, nan) を返します.
     **/
    Line bisector(const Point p1, const Point p2)
    {
      auto a = p2.x-p1.x;
      auto b = p2.y-p1.y;
      auto c = (p1.x^^2 - p2.x^^2 + p1.y^^2 - p2.y^^2) / 2;
      if (approxEqual(a, 0, eps) && approxEqual(b, 0, eps))
        return Line(T.nan, T.nan, T.nan);
      return Line(a, b, c);
    }
  }

  pure nothrow @safe
  {
    /**
     ** 直線 l1, l2 の角の二等分線を配列で返します.
     ** l1, l2 が平行とみなされる場合は1つだけを返します.
     **/
    Line[] bisector(const Line l1, const Line l2)
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
}
// ::::::::::::::::::::

unittest
{
  alias geom = Geom!double, P = geom.Point, L = geom.Line;
  auto eps = 1e-10;

  assert(approxEqual(geom.dist(P(0, 0), P(3, 4)), 5, eps));
  assert(approxEqual(geom.dist(P(0, 0), L(3, -4, -2)), 0.4, eps));

  auto r1 = geom.intersect(L(1, -1, 3), L(2, 1, -6));
  assert(approxEqual(r1.x, 1, eps));
  assert(approxEqual(r1.y, 4, eps));

  assert(geom.intersect(L(1, 1, 0), L(2, 2, 0)).isNaN);

  auto r2 = geom.bisector(P(1, 3), P(5, 1));
  assert(approxEqual(r2.c/r2.a, -2, eps));
  assert(approxEqual(r2.c/r2.b, 4, eps));

  assert(geom.bisector(P(1, 1), P(1, 1)).isNaN);

  auto r3 = geom.bisector(L(2, -1, -3), L(1, -2, 0));
  assert(approxEqual(r3[0].c/r3[0].a, -3, eps));
  assert(approxEqual(r3[0].c/r3[0].b, -3, eps));
  assert(approxEqual(r3[1].c/r3[1].a, -1, eps));
  assert(approxEqual(r3[1].c/r3[1].b, 1, eps));

  auto r4 = geom.bisector(L(1, 1, 0), L(2, 2, 0));
  assert(approxEqual(r4[0].c/r4[0].a, 0, eps));
  assert(approxEqual(r4[0].c/r4[0].b, 0, eps));
}
