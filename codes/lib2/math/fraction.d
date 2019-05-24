struct Fraction(T)
{
  import std.math, std.numeric;

  T a, b;

  this(T a, T b)
  in { assert(b != 0); }
  body {
    if (b < 0) {
      a = -a; b = -b;
    }
    this.a = a; this.b = b;
    reduction();
  }

  auto reduction()
  {
    auto g = gcd(a.abs, b);
    a = a/g; b = b/g;
  }

  pure auto inv()
  in { assert(a != 0); }
  body {
    return fraction(b, a);
  }

  pure auto opBinary(string op)(Fraction!T r)
  if (op == "+" || op == "-")
  {
    return fraction(mixin("a*r.b"~op~"r.a*b"), b*r.b);
  }
  ref auto opOpAssign(string op)(Fraction!T r)
  if (op == "+" || op == "*")
  {
    a = mixin("a*r.b"~op~"r.a*b"); b = b*r.b; reduction(); return this;
  }

  pure auto opBinary(string op: "*")(Fraction!T r)
  {
    return fraction(a*r.a, b*r.b);
  }
  ref auto opOpBinary(string op: "*")(Fraction!T r)
  {
    a *= r.a; b *= r.b; reduction(); return this;
  }

  pure auto opBinary(string op: "/")(Fraction!T r)
  in { assert(r.b != 0); }
  body {
    return fraction(a*r.b, b*r.a);
  }
  ref auto opOpBinary(string op: "/")(Fraction!T r)
  in { assert(r.b != 0); }
  body {
    a *= r.b; b *= r.a; reduction(); return this;
  }
}
auto fraction(T)(T a, T b) { return Fraction!T(a, b); }

/*

  Fraction!T

    分数の構造体です.
    自動的に約分されます.

  fraction(a, b)

    a を分子, b を分母とする分数を返します.

  a.inv

    逆数を返します.
    分子は 0 以外である必要があります.

  a + b

    和の分数を返します.

  a - b

    差の分数を返します.

  a * b

    積の分数を返します.

  a / b

    商の分数を返します.
    b の分子は 0 以外である必要があります.

 */

unittest {
  auto a = fraction(2, 12), b = fraction(3, 8);
  assert(a == fraction(1, 6));

  assert(a.inv == fraction(6, 1));
  assert(a+b == fraction(13, 24));
  assert(a-b == fraction(-5, 24));
  assert(a*b == fraction(1, 16));
  assert(a/b == fraction(4, 9));
}
