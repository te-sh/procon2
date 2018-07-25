// URL: https://beta.atcoder.jp/contests/arc042/tasks/arc042_b

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int px, py; readV(px, py);
  int n; readV(n);
  int[] x, y; readC(n, x, y);

  mixin Geom!real;
  auto p = Point(px, py);
  auto l = new Line[](n);
  l[0] = line(Point(x[$-1], y[$-1]), Point(x[0], y[0]));
  foreach (i; 1..n) l[i] = line(Point(x[i-1], y[i-1]), Point(x[i], y[i]));

  writefln("%.7f", l.map!(li => dist(p, li)).reduce!min);
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

  auto line(Point p1, Point p2)
  {
    auto x = p2.x-p1.x;
    auto y = p2.y-p1.y;
    return Line(y, -x, p2.y*x-p2.x*y);
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
