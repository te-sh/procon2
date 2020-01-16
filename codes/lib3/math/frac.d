struct Frac(T)
{
  import std.math, std.numeric;
  alias F = Frac!T, Op = string;
  T a, b;

  this(T a, T b) in { assert(b != 0); } do { this.a = a; this.b = b; }

  ref F reduction()
  {
    auto g = gcd(a.abs, b);
    a /= g; b /= g;
    return this;
  }
  ref F normalizeSign() { if (b < 0) { a = -a; b = -b; } return this; }

  pure F inv() in { assert(a != 0); } do { return F(b, a).normalizeSign; }
  pure F opUnary(Op op: "-")() { return F(-a, b); }

  pure F opBinary(Op op)(F r) if (op=="+"||op=="-")
  {
    auto g = gcd(b, r.b);
    return F(mixin("r.b/g*a"~op~"b/g*r.a"), b/g*r.b).reduction();
  }
  ref F opOpAssign(Op op)(F r) if (op=="+"||op=="-")
  {
    auto g = gcd(b, r.b);
    a = mixin("r.b/g*a"~op~"b/g*r.a"); b = b/g*r.b; return reduction();
  }

  pure F opBinary(Op op: "*")(F r)
  {
    auto g1 = gcd(a.abs, r.b), g2 = gcd(r.a.abs, b);
    return F((a/g1)*(r.a/g2), (b/g2)*(r.b/g1));
  }
  ref F opOpAssign(Op op: "*")(F r)
  {
    auto g1 = gcd(a.abs, r.b), g2 = gcd(r.a.abs, b);
    a = (a/g1)*(r.a/g2); b = (b/g2)*(r.b/g1); return this;
  }

  pure F opBinary(Op op: "/")(F r) in { assert(r.b != 0); } do
  {
    auto g1 = gcd(a.abs, r.a.abs), g2 = gcd(b, r.b);
    return F((a/g1)*(r.b/g2), (b/g2)*(r.a/g1)).normalizeSign();
  }
  ref F opOpAssign(Op op: "/")(F r) in { assert(r.b != 0); } do
  {
    auto g1 = gcd(a.abs, r.a.abs), g2 = gcd(b, r.b);
    a = (a/g1)*(r.b/g2); b = (b/g2)*(r.a/g1); return normalizeSign();
  }
}
auto frac(T)(T a, T b) { return Frac!T(a, b).normalizeSign().reduction(); }

/*

  struct Frac(T)

    分数を表します.

    Frac!T(T a, T b)

      a/b を示す分数を返します.
      b は 0 以外である必要があります.

    -a

      -a を返します.

    a + b
    a - b
    a * b
    a / b

      四則演算の結果を返します.
      自動的に約分されます.
      `/` については b は 0 以外である必要があります.

    a += b
    a -= b
    a *= b
    a /= b

      四則演算を行います.
      自動的に約分されます.
      `/` については b は 0 以外である必要があります.

    pure Frac!T inv()

      a の逆数を返します.
      a は 0 以外である必要があります.

 */

unittest
{
  alias F = Frac!int;
  auto a = frac(2, -12), b = frac(3, 8);
  assert(a == F(-1, 6));

  assert(-a == F(1, 6));
  assert(a.inv == F(-6, 1));
  assert(a+b == F(5, 24));
  assert(a-b == F(-13, 24));
  assert(a*b == F(-1, 16));
  assert(a/b == F(-4, 9));

  a = F(-1, 6); a += b;
  assert(a == F(5, 24));
  a = F(-1, 6); a -= b;
  assert(a == F(-13, 24));
  a = F(-1, 6); a *= b;
  assert(a == F(-1, 16));
  a = F(-1, 6); a /= b;
  assert(a == F(-4, 9));
}
