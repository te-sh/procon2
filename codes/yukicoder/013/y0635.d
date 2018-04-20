// URL: https://yukicoder.me/problems/no/635

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

mixin Geom!real;
const inf = 1.0e+10L;

version(unittest) {} else
void main()
{
  int n; readV(n);
  foreach (_; 0..n) {
    int x1, x2, x3, y1, y2, y3; readV(x1, x2, x3, y1, y2, y3);
    writeln(calc(x1, x2, x3, y1, y2, y3) ? "YES" : "NO");
  }
}

struct Section
{
  real a, b;

  static auto nan() { return Section(real.nan, real.nan); }
  auto isNaN() { return a.isNaN || b.isNaN; }

  auto opBinary(string op: "~")(Section s2)
  {
    auto s1 = this;
    if (s1.isNaN || s2.isNaN) return Section.nan;
    if (s1.a > s2.a) swap(s1, s2);
    auto s = Section(max(s1.a, s2.a), min(s1.b, s2.b));
    if (s.a >= s.b) s = Section.nan;
    return s;
  }
}

auto calc(int x1, int x2, int x3, int y1, int y2, int y3)
{
  if (x1 == x2 && y1 == y2 || x2 == x3 && y2 == y3 || x3 == x1 && y3 == y1) return false;

  auto s1 = getSection(x1, x2, y1, y2), s2 = getSection(x3, x2, y3, y2);
  auto s12 = s1 ~ s2;
  if (s12.b > 0) return true;

  auto s3 = getSection(x2, x1, y2, y1), s4 = getSection(x2, x3, y2, y3);
  auto s34 = s3 ~ s4;
  if (s34.b > 0) return true;

  return false;
}

auto getSection(int x1, int x2, int y1, int y2)
{
  auto l1 = Line(y1, -1, x1), l2 = Line(y2, -1, x2);
  if (y1 == y2) {
    return x1 > x2 ? Section(-inf, inf) : Section.nan;
  } else {
    auto p = intersect(l1, l2);
    return y1 > y2 ? Section(p.x, inf) : Section(-inf, p.x);
  }
}

template Geom(T, T eps = T(10) ^^ (-10))
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

  auto dist(Point p1, Point p2)
  {
    return ((p1.x - p2.x) ^^ 2 + (p1.y - p2.y) ^^ 2).sqrt;
  }

  auto dist(Point p, Line l)
  {
    return (l.a * p.x + l.b * p.y + l.c).abs / (l.a ^^ 2 + l.b ^^ 2).sqrt;
  }

  auto intersect(Line l1, Line l2)
  {
    auto det = l1.a * l2.b - l1.b * l2.a;
    if (det.abs < eps) return Point(T.nan, T.nan);
    auto x = (l1.b * l2.c - l2.b * l1.c) / det;
    auto y = (l2.a * l1.c - l1.a * l2.c) / det;
    return Point(x, y);
  }

  auto bisector(Point p1, Point p2)
  {
    auto a = p2.x - p1.x;
    auto b = p2.y - p1.y;
    auto c = (p1.x ^^ 2 - p2.x ^^ 2 + p1.y ^^ 2 - p2.y ^^ 2) / 2;
    if (a.abs < eps && b.abs < eps) return Line(T.nan, T.nan, T.nan);
    return Line(a, b, c);
  }

  auto bisector(Line l1, Line l2)
  {
    auto d1 = (l1.a ^^ 2 + l1.b ^^ 2).sqrt;
    auto d2 = (l2.a ^^ 2 + l2.b ^^ 2).sqrt;

    Line[] r;

    auto a3 = l1.a * d2 - l2.a * d1;
    auto b3 = l1.b * d2 - l2.b * d1;
    auto c3 = l1.c * d2 - l2.c * d1;
    if (a3.abs >= eps || b3.abs >= eps) r ~= Line(a3, b3, c3);

    auto a4 = l1.a * d2 + l2.a * d1;
    auto b4 = l1.b * d2 + l2.b * d1;
    auto c4 = l1.c * d2 + l2.c * d1;
    if (a4.abs >= eps || b4.abs >= eps) r ~= Line(a4, b4, c4);

    return r;
  }
}
