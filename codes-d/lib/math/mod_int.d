module lib.math.mod_int;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.math.mod_int
import lib.math.misc;

struct ModInt(int m, bool pos = false)
{
  version(BigEndian) union { long l; struct { int i2; int i; } } else union { long l; int i; }
  alias M = ModInt!(m, pos), Op = string;
  static init() { return M(0); }
  @property int value() { return i; }
  @property void value(int v) { i = nm(v); }
  alias value this;

  this(T)(T v = 0) { i = nm(v); }
  ref M opAssign(T)(T v) { i = nm(v); return this; }

  pure int nm(int v) { static if (pos) return v%m; else return (v%m+m)%m; }
  pure int nm(long v) { static if (pos) return cast(int)(v%m); else return cast(int)((v%m+m)%m); }

  static if (!pos) pure M opUnary(Op op: "-")() { return M(-i); }

  static if (m < int.max / 2) {
    pure M opBinary(Op op)(int r) if(op=="+"||!pos&&op=="-") { return M(mixin("i"~op~"r")); }
    ref M opOpAssign(Op op)(int r) if(op=="+"||!pos&&op=="-") { i=nm(mixin("i"~op~"r")); return this; }
  } else {
    pure M opBinary(Op op)(int r) if(op=="+"||!pos&&op=="-") { return M(mixin("l"~op~"r")); }
    ref M opOpAssign(Op op)(int r) if(op=="+"||!pos&&op=="-") { i=nm(mixin("l"~op~"r")); return this; }
  }
  pure M opBinary(Op op: "*")(int r) { return M(l*r); }
  ref M opOpAssign(Op op: "*")(int r) { i=nm(l*r); return this; }

  pure M opBinary(Op op)(M r) if(op=="+"||!pos&&op=="-"||op=="*") { return opBinary!op(r.i); }
  ref M opOpAssign(Op op)(M r) if(op=="+"||!pos&&op=="-"||op=="*") { return opOpAssign!op(r.i); }

  pure M opBinary(Op op: "^^", T)(T n) { return this.powr(n); }

  static if (!pos) {
    pure M opBinary(Op op: "/")(M r) { return M(l*r.inv.i); }
    ref M opOpAssign(Op op: "/")(M r) { i=nm(l*r.inv.i); return this; }

    pure M opBinary(Op op: "/")(int r) { return opBinary!op(M(r)); }
    ref M opOpAssign(Op op: "/")(int r) { return opOpAssign!op(M(r)); }

    pure M inv() { int x = i, a, b; extGcd(x, m, a, b); return M(a); }
  }
}
// ::::::::::::::::::::

/*

  struct ModInt(int m, bool pos = false)

    m を法とする剰余群を表します.
    pos が true のときは内部が負になる状態を扱わない分, 高速化します.
    ただし, 一部の演算子は定義されません.

    -a

      -a を返します.
      pos が true のときは定義されません.

    a + b
    a - b
    a * b
    a / b

      四則演算の結果を返します.
      b は ModInt か int を取ります.
      `-` と `/` は pos が true のときは定義されません.

    a += b
    a -= b
    a *= b
    a /= b

      四則演算を行います.
      b は ModInt か int を取ります.
      `-` と `/` は pos が true のときは定義されません.

    a ^^ b

      a の b 乗を返します.

    pure ModInt!(m, pos) inv()

      a の逆数を返します.
      m が素数でない場合は正しい値を返しません.
      pos が true のときは定義されません.

*/

unittest
{
  import std.conv;
  alias mint = ModInt!7;

  assert(mint.init == 0);
  assert(19.to!mint == 5);

  mint a = 17, b = 19L;
  assert(a == 3);
  assert(b == 5);
  assert(-a == 4);
  assert(a+b == 1);
  assert(a-b == 5);
  assert(a*b == 1);
  assert(a+19 == 1);
  assert(a-19 == 5);
  assert(a*19 == 1);
  assert(a^^3 == 6);
  assert(a/b == 2);
  assert(b.inv == 3);

  a = 18; a += b;
  assert(a == 2);
  a = 18; a -= b;
  assert(a == 6);
  a = 18; a *= b;
  assert(a == 6);
  a = 18; a /= b;
  assert(a == 5);

  alias mint2 = ModInt!(7, true);
  mint2 c = 17, d = 19L;
  assert(c == 3);
  assert(d == 5);
  assert(c+d == 1);
  assert(c*d == 1);
}
