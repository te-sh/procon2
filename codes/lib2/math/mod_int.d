struct ModInt(int m, bool pos = false)
{
  version(BigEndian) union { long l; struct { int i2; int i; } } else union { long l; int i; }
  alias M = ModInt!(m, pos);
  @property static init() { return M(0); }
  @property int value() { return i; }
  @property void value(int v) { i = mod(v); }
  alias value this;

  this(int v) { i = v; }
  this(int v, bool runMod) { i = runMod ? mod(v) : v; }
  this(long v) { i = mod(v); }

  ref auto opAssign(int v) { i = v; return this; }

  pure auto mod(int v) const { static if (pos) return v%m; else return (v%m+m)%m; }
  pure auto mod(long v) const { static if (pos) return cast(int)(v%m); else return cast(int)((v%m+m)%m); }

  static if (!pos) pure auto opUnary(string op: "-")() { return M(mod(-i)); }

  static if (m < int.max / 2) {
    pure auto opBinary(string op)(int r) if (op == "+" || op == "-") { return M(mod(mixin("i"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { i = mod(mixin("i"~op~"r")); return this; }
  } else {
    pure auto opBinary(string op)(int r) if (op == "+" || op == "-") { return M(mod(mixin("l"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { i = mod(mixin("l"~op~"r")); return this; }
  }
  pure auto opBinary(string op: "*")(int r) { return M(mod(l*r)); }
  ref auto opOpAssign(string op: "*")(int r) { i = mod(l*r); return this; }

  pure auto opBinary(string op)(M r) if (op == "+" || op == "-" || op == "*") { return opBinary!op(r.i); }
  ref auto opOpAssign(string op)(M r) if (op == "+" || op == "-" || op == "*") { return opOpAssign!op(r.i); }

  pure auto opBinary(string op: "/")(M r) { return M(mod(l*r.inv.i)); }
  ref auto opOpAssign(string op: "/")(M r) { i = mod(l*r.inv.i); return this; }

  pure auto opBinary(string op: "/")(int r) { return opBinary!op(M(r)); }
  ref auto opOpAssign(string op: "/")(int r) { return opOpAssign!op(M(r)); }

  pure auto opBinary(string op: "^^", U)(U n)
  {
    auto x = M(1);
    if (n == 0) return x;

    auto b = M(i);
    for (; n > 0; n >>= 1) {
      if (n&1) x *= b;
      b *= b;
    }

    return x;
  }

  pure auto inv()
  {
    int x = i, a, b;
    exEuclid(x, m, a, b);
    return M(mod(a));
  }

  pure int exEuclid(int a, int b, ref int x, ref int y)
  {
    auto g = a;
    x = 1; y = 0;
    if (b) {
      g = exEuclid(b, a%b, y, x);
      y -= a/b*x;
    }
    return g;
  }
}

/*

  ModInt!m

    m を法とする剰余環上の数を表す構造体です.

  a + b

    和を返します. b は ModInt!m か int を取れます.

  a - b

    差を返します. b は ModInt!m か int を取れます.

  a * b

    積を返します. b は ModInt!m か int を取れます.

  a / b

    a * b.inv を返します. b は ModInt!m か int を取れます.
    m が素数でない場合は正しい値を返しません.

  a ^^ n

    a の n 乗を返します.
    内部では繰り返し2乗法を使っています.

  a.inv

    逆数を返します.
    m が素数でない場合は正しい値を返しません.

 */

unittest
{
  import std.algorithm, std.array, std.conv;
  alias ModInt!(2_000_000_000) mint;

  assert(mint.init == 0);
  assert(5.to!mint == mint(5));

  assert(mint(2_100_000_001, true) == 100_000_001);
  assert(mint(2_100_000_001, true) > 100_000_000);
  assert(mint(2_100_000_000, true) < 100_000_002);

  auto a = new mint[](1);
  a[0] = 1;
  assert(a[0] == 1);
  a[0] += 3;
  assert(a[0] == 4);
  a[0] -= 1;
  assert(a[0] == 3);
  a[0] *= 3;
  assert(a[0] == 9);

  assert(-mint(1_999_999_999) == 1);

  assert(mint(1_800_000_000) + mint(1_700_000_000) == 1_500_000_000);
  assert(mint(1_800_000_000) * (-1) - mint(1_700_000_000) == 500_000_000);
  assert(mint(123_456_789) * mint(123_456_789) == 750_190_521);

  assert(mint(1_800_000_000) + 1_700_000_000 == 1_500_000_000);
  assert(mint(1_800_000_000) * (-1) - 1_700_000_000 == 500_000_000);
  assert(mint(123_456_789) * 123_456_789 == 750_190_521);

  assert(ModInt!11(6) / ModInt!11(3) == 2);
  assert(ModInt!11(6) / 3 == 2);

  assert(ModInt!7(6) ^^ 3 == 6);

  assert(ModInt!11(3).inv == 4);
  assert(ModInt!7(4).inv == 2);

  mint[] b = [1, 2, 3].map!(to!mint).array;
  assert(b.sum == 6);
}
