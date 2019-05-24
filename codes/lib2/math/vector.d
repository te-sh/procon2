template Vector(T)
{
  struct Vector2
  {
    T x, y;
    pure auto opBinary(string op)(Vector2 r) if (op == "+" || op == "-") { return mixin("Vector2(x"~op~"r.x,y"~op~"r.y)"); }
    ref auto opOpAssign(string op)(Vector2 r) if (op == "+" || op == "-") { mixin("x"~op~"=r.x; y"~op~"=r.y;"); return this; }
    pure auto opBinary(string op)(T a) if (op == "*" || op == "/") { return mixin("Vector2(x"~op~"a,y"~op~"a)"); }
    ref auto opOpAssign(string op)(T a) if (op == "*" || op == "/") { mixin("x"~op~"=a; y"~op~"=a;"); return this; }
    pure auto opBinary(string op: "*")(Vector2 r) { return x*r.x + y*r.y; }
    pure auto hypot2() const { return x^^2 + y^^2; }
  }

  struct Vector3
  {
    T x, y, z;
    pure auto opBinary(string op)(Vector3 r) if (op == "+" || op == "-") { return mixin("Vector3(x"~op~"r.x,y"~op~"r.y,z"~op~"r.z)"); }
    ref auto opOpAssign(string op)(Vector3 r) if (op == "+" || op == "-") { mixin("x"~op~"=r.x; y"~op~"=r.y; z"~op~"=r.z;"); return this; }
    pure auto opBinary(string op)(T a) if (op == "*" || op == "/") { return mixin("Vector3(x"~op~"a,y"~op~"a,z"~op~"a)"); }
    ref auto opOpAssign(string op)(T a) if (op == "*" || op == "/") { mixin("x"~op~"=a; y"~op~"=a; z"~op~"=a;"); return this; }
    pure auto opBinary(string op: "*")(Vector3 r) { return x*r.x + y*r.y + z*r.z; }
    pure auto hypot2() const { return x^^2 + y^^2 + z^^2; }
  }

  pure auto outerProd(Vector3 p1, Vector3 p2)
  {
    return Vector3(p1.y*p2.z - p1.z*p2.y, p1.z*p2.x - p1.x*p2.z, p1.x*p2.y - p1.y*p2.x);
  }
}

/*
  Vector!T

    ベクトルに関する処理を集めたものです.

  Vector2

    2次元ベクトルを表す構造体です.

  Vector3

    3次元ベクトルを表す構造体です.

  v1 + v2

    ベクトル v1 と v2 の和を返します.

  v1 - v2

    ベクトル v1 と v2 の和を返します.

  v * t

    ベクトル v の t 倍のベクトルを返します.

  v / t

    ベクトル v の 1/t 倍のベクトルを返します.

  v1 * v2

    ベクトル v1, v2 の内積を返します.

  v.hypot2

    ベクトル v の大きさの2乗を返します.

  outerProd(v1, v2)

    3次元ベクトル v1, v2 の外積を返します.

 */

unittest
{
  mixin Vector!int;

  auto v1 = Vector2(2, 4);

  assert(v1.x == 2);
  assert(v1.y == 4);

  auto v2 = Vector2(1, 3);

  assert(v1 + v2 == Vector2(3, 7));
  assert(v1 - v2 == Vector2(1, 1));
  assert(v1 * v2 == 14);
  assert(v1 * 2 == Vector2(4, 8));
  assert(v1 / 3 == Vector2(0, 1));

  assert(v1.hypot2 == 20);

  v1 += v2;
  assert(v1 == Vector2(3, 7));
  v1 -= v2;
  assert(v1 == Vector2(2, 4));
  v1 *= 2;
  assert(v1 == Vector2(4, 8));
  v1 /= 2;
  assert(v1 == Vector2(2, 4));

  auto v3 = Vector3(2, 4, 5);

  assert(v3.x == 2);
  assert(v3.y == 4);
  assert(v3.z == 5);

  auto v4 = Vector3(1, 3, 2);

  assert(v3 + v4 == Vector3(3, 7, 7));
  assert(v3 - v4 == Vector3(1, 1, 3));
  assert(v3 * v4 == 24);
  assert(v3 * 2 == Vector3(4, 8, 10));
  assert(v3 / 2 == Vector3(1, 2, 2));

  assert(v3.hypot2 == 45);

  assert(outerProd(v3, v4) == Vector3(-7, 1, 2));

  v3 += v4;
  assert(v3 == Vector3(3, 7, 7));
  v3 -= v4;
  assert(v3 == Vector3(2, 4, 5));
  v3 *= 2;
  assert(v3 == Vector3(4, 8, 10));
  v3 /= 2;
  assert(v3 == Vector3(2, 4, 5));
}
