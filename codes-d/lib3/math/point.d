struct Point2(T)
{
  alias P = Point2!T, Op = string;
  T x, y;
  pure P opBinary(Op o)(P r) if (o=="+"||o=="-") {return mixin("P(x"~o~"r.x,y"~o~"r.y)");}
  pure P opBinary(Op o)(T a) if (o=="*"||o=="/") {return mixin("P(x"~o~"a,y"~o~"a)");}
  P opOpAssign(Op o)(P r) if (o=="+"||o=="-") {mixin("x"~o~"=r.x;y"~o~"=r.y;");return this;}
  P opOpAssign(Op o)(T a) if (o=="*"||o=="/") {mixin("x"~o~"=a;y"~o~"=a;");return this;}
  pure T opBinary(Op o: "*")(P r) {return x*r.x+y*r.y;}
  pure T hypot2() {return x^^2+y^^2;}
}

pure T cross(T)(Point2!T p1, Point2!T p2)
{
  return p1.x*p2.y - p1.y*p2.x;
}

struct Point3(T)
{
  alias P = Point3!T, Op = string;
  T x, y, z;
  pure P opBinary(Op o)(P r) if (o=="+"||o=="-") {return mixin("P(x"~o~"r.x,y"~o~"r.y,z"~o~"r.z)");}
  pure P opBinary(Op o)(T a) if (o=="*"||o=="/") {return mixin("P(x"~o~"a,y"~o~"a,z"~o~"a)");}
  P opOpAssign(Op o)(P r) if (o=="+"||o=="-") {mixin("x"~o~"=r.x;y"~o~"=r.y;z"~o~"=r.z;");return this;}
  P opOpAssign(Op o)(T a) if (o=="*"||o=="/") {mixin("x"~o~"=a;y"~o~"=a;z"~o~"=a;");return this;}
  pure T opBinary(Op o: "*")(P r) {return x*r.x+y*r.y+z*r.z;}
  pure T hypot2() {return x^^2+y^^2+z^^2;}
}

pure Point3!T cross(T)(Point3!T p1, Point3!T p2)
{
  return Point3!T(p1.y*p2.z - p1.z*p2.y, p1.z*p2.x - p1.x*p2.z, p1.x*p2.y - p1.y*p2.x);
}

/*

  struct Point2(T)

    2次元平面上の点を表します.

    a + b
    a - b

      a, b をベクトルとしてその和または差を返します.

    a * b
    a / b

      a をベクトルとしてスカラー b を掛けたまたは割った結果を返します.

    a * b

      a, b をベクトルとしてその内積を返します.

    a += b
    a -= b

      a, b をベクトルとしてその和または差を計算します.

    a *= b
    a /= b

      a をベクトルとしてスカラー b を掛けるまたは割る計算を行います.

    pure T hypot2()

      自身との内積を返します.

  pure T cross(T)(Point2!T p1, Point2!T p2)

    p1, p2 を平面上にある3次元ベクトルとしてそのクロス積の z 方向の値を返します.

  struct Point3(T)

    3次元平面上の点を表します.

    a + b
    a - b

      a, b をベクトルとしてその和または差を返します.

    a * b
    a / b

      a をベクトルとしてスカラー b を掛けたまたは割った結果を返します.

    a * b

      a, b をベクトルとしてその内積を返します.

    a += b
    a -= b

      a, b をベクトルとしてその和または差を計算します.

    a *= b
    a /= b

      a をベクトルとしてスカラー b を掛けるまたは割る計算を行います.

    pure T hypot2()

      自身との内積を返します.

  pure Point3!T cross(T)(Point3!T p1, Point3!T p2)

    p1, p2 をベクトルとしてそのクロス積を返します.

*/

unittest
{
  alias Point2!int point;
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
  alias Point3!int point3;
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
