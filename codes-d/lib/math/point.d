module lib.math.point;
import std;

// :::::::::::::::::::: lib.math.point
/**
 ** 2次元平面上の点を表します.
 **/
struct Point2(T)
{
  /**
   ** x 座標, y 座標の値です.
   **/
  T x, y;

  pure nothrow @nogc @safe
  {
    /**
     ** p, r をベクトルとして, p+r, p-r を返します. r は p と同じタイプです.
     **/
    Point2!T opBinary(string op)(const Point2!T r) const
      if (op == "+" || op == "-")
    {
      return mixin("Point2(x"~op~"r.x, y"~op~"r.y)");
    }
    /**
     ** p, r をベクトルとして, p+=r, p-=r を計算します. r は p と同じタイプです.
     **/
    Point2!T opOpAssign(string op)(const Point2!T r)
      if (op == "+" || op == "-")
    {
      mixin("x"~op~"=r.x; y"~op~"=r.y;");
      return this;
    }
    /**
     ** p をベクトルとして, p*a, p/a を返します. r は数値です.
     **/
    Point2!T opBinary(string op, U)(U a) const
      if ((op == "*" || op == "/") && isIntegral!U)
    {
      return mixin("Point2(x"~op~"a, y"~op~"a)");
    }
    /**
     ** p をベクトルとして, p*=a, p/=a を計算します. r は数値です.
     **/
    Point2!T opOpAssign(string op, U)(U a)
      if ((op == "*" || op == "/") && isIntegral!U)
    {
      mixin("x"~op~"=a; y"~op~"=a;");
      return this;
    }
    /**
     ** p, r をベクトルとして, p と r の内積を返します.
     **/
    T opBinary(string op: "*")(const Point2!T r) const
    {
      return x*r.x+y*r.y;
    }
    /**
     ** p をベクトルとして, p とそれ自身の内積を返します.
     **/
    T hypot2() const
    {
      return x^^2+y^^2;
    }
  }
}

pure nothrow @nogc @safe
{
  /**
   ** p1, p2 のマンハッタン距離を返します.
   **/
  T distManhattan(T)(const Point2!T p1, const Point2!T p2)
  {
    return (p1.x-p2.x).abs + (p1.y-p2.y).abs;
  }

  /**
   ** p1, p2 を平面上にある3次元ベクトルとしてそのクロス積の z 成分を返します.
   **/
  T cross(T)(const Point2!T p1, const Point2!T p2)
  {
    return p1.x*p2.y - p1.y*p2.x;
  }
}

/**
 ** 3次元空間内の点を表します.
 **/
struct Point3(T)
{
  /**
   ** x 座標, y 座標, z 座標の値です.
   **/
  T x, y, z;

  pure nothrow @nogc @safe
  {
    /**
     ** p, r をベクトルとして, p+r, p-r を返します. r は p と同じタイプです.
     **/
    Point3!T opBinary(string op)(const Point3!T r) const
      if (op == "+" || op == "-")
    {
      return mixin("Point3!T(x"~op~"r.x, y"~op~"r.y, z"~op~"r.z)");
    }
    /**
     ** p, r をベクトルとして, p+=r, p-=r を計算します. r は p と同じタイプです.
     **/
    Point3!T opOpAssign(string op)(const Point3!T r)
      if (op == "+" || op == "-")
    {
      mixin("x"~op~"=r.x; y"~op~"=r.y; z"~op~"=r.z;");
      return this;
    }
    /**
     ** p をベクトルとして, p*a, p/a を返します. r は数値です.
     **/
    Point3!T opBinary(string op, U)(U a) const
      if ((op == "*" || op == "/") && isIntegral!U)
    {
      return mixin("Point3!T(x"~op~"a, y"~op~"a, z"~op~"a)");
    }
    /**
     ** p をベクトルとして, p*=a, p/=a を計算します. r は数値です.
     **/
    Point3!T opOpAssign(string op, U)(U a)
      if ((op == "*" || op == "/") && isIntegral!U)
    {
      mixin("x"~op~"=a; y"~op~"=a; z"~op~"=a;");
      return this;
    }
    /**
     ** p, r をベクトルとして, p と r の内積を返します.
     **/
    T opBinary(string o: "*")(const Point3!T r) const
    {
      return x*r.x+y*r.y+z*r.z;
    }
    /**
     ** p をベクトルとして, p とそれ自身の内積を返します.
     **/
    T hypot2() const
    {
      return x^^2+y^^2+z^^2;
    }
  }
}

pure nothrow @nogc @safe
{
  /**
   ** p1, p2 をベクトルとしてそのクロス積を返します.
   **/
  Point3!T cross(T)(const Point3!T p1, const Point3!T p2)
  {
    return Point3!T(p1.y*p2.z - p1.z*p2.y, p1.z*p2.x - p1.x*p2.z, p1.x*p2.y - p1.y*p2.x);
  }
}
// ::::::::::::::::::::

unittest
{
  alias point = Point2!int;
  auto p1 = point(2, 4);

  assert(p1.x == 2);
  assert(p1.y == 4);

  auto p2 = point(1, 3);

  assert(p1 + p2 == point(3, 7));
  assert(p1 - p2 == point(1, 1));
  assert(p1 * p2 == 14);
  assert(p1 * 2 == point(4, 8));
  assert(p1 / 3 == point(0, 1));

  assert(p1.hypot2 == 20);
  assert(cross(p1, p2) == 2);
  assert(distManhattan(p1, p2) == 2);

  p1 = point(2, 4); p1 += p2;
  assert(p1 == point(3, 7));
  p1 = point(2, 4); p1 -= p2;
  assert(p1 == point(1, 1));
  p1 = point(2, 4); p1 *= 2;
  assert(p1 == point(4, 8));
  p1 = point(2, 4); p1 /= 2;
  assert(p1 == point(1, 2));
}

unittest
{
  alias point3 = Point3!int;
  auto p1 = point3(2, 4, 5);

  assert(p1.x == 2);
  assert(p1.y == 4);
  assert(p1.z == 5);

  auto p2 = point3(1, 3, 2);

  assert(p1 + p2 == point3(3, 7, 7));
  assert(p1 - p2 == point3(1, 1, 3));
  assert(p1 * p2 == 24);
  assert(p1 * 2 == point3(4, 8, 10));
  assert(p1 / 2 == point3(1, 2, 2));

  assert(p1.hypot2 == 45);
  assert(cross(p1, p2) == point3(-7, 1, 2));

  p1 = point3(2, 4, 5); p1 += p2;
  assert(p1 == point3(3, 7, 7));
  p1 = point3(2, 4, 5); p1 -= p2;
  assert(p1 == point3(1, 1, 3));
  p1 = point3(2, 4, 5); p1 *= 2;
  assert(p1 == point3(4, 8, 10));
  p1 = point3(2, 4, 5); p1 /= 2;
  assert(p1 == point3(1, 2, 2));
}
