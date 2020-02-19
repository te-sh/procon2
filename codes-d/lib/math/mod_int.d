module lib.math.mod_int;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.math.mod_int
import lib.math.misc;

/**
 ** m を法とする剰余群を表します.
 ** pos が true のときは内部が負になる状態を扱わない分高速化しますが, 一部の演算子は定義されません.
 **/
struct ModInt(int m, bool pos = false)
{
  pure nothrow @nogc @safe:
  /**
   ** 剰余群の初期値 0 を返します.
   **/
  @property static init() { return M(0); }
  /**
   ** 値を int で返します.
   **/
  @property int value() { return i; }
  /**
   ** 値を int でセットします.
   **/
  @property void value(int v) { i = nm(v); }
  alias value this;

  /**
   ** v から作成した剰余群を返します.
   ** v は Integral です.
   **/
  this(T)(T v = 0) if (isIntegral!T) { i = nm(v); }
  /**
   ** 自身に v から作成した剰余群を代入します.
   ** v は Integral です.
   **/
  ref M opAssign(T)(T v) if (isIntegral!T) { i = nm(v); return this; }
  /**
   ** 自身に v を代入します.
   ** v は同じタイプです.
   **/
  ref M opAssign(M v) { i = v.i; return this; }

  /**
   ** -a を返します.
   ** pos が true のときは定義されません.
   **/
  static if (!pos) M opUnary(string op: "-")() { return M(-i); }

  static if (m < int.max / 2) {
    /**
     ** a+r, a-r を返します. r は Integral です.
     ** pos が false のときは a-b は定義されません.
     **/
    M opBinary(string op, T)(T r) if ((op=="+"||!pos&&op=="-")&&isIntegral!T)
    { return M(mixin("i"~op~"r")); }
    /**
     ** a+=r, a-=r を計算します. r は Integral です.
     ** pos が false のときは a-=b は定義されません.
     **/
    ref M opOpAssign(string op, T)(T r) if ((op=="+"||!pos&&op=="-")&&isIntegral!T)
    { i = nm(mixin("i"~op~"r")); return this; }
  } else {
    /**
     ** a+r, a-r を返します. r は Integral です.
     ** pos が false のときは a-b は定義されません.
     **/
    M opBinary(string op, T)(T r) if ((op=="+"||!pos&&op=="-")&&isIntegral!T)
    { return M(mixin("l"~op~"r")); }
    /**
     ** a+=r, a-=r を計算します. r は int です.
     ** pos が false のときは a-=b は定義されません.
     **/
    ref M opOpAssign(string op, T)(T r) if ((op=="+"||!pos&&op=="-")&&isIntegral!T)
    { i = nm(mixin("l"~op~"r")); return this; }
  }
  /**
   ** a*r を返します. r は Integral です.
   **/
  M opBinary(string op: "*", T)(T r) if (isIntegral!T) { return M(l*r); }
  /**
   ** a*=r を計算します. r は Integral です.
   **/
  ref M opOpAssign(string op: "*", T)(T r) if (isIntegral!T) { i = nm(l*r); return this; }

  /**
   ** a+r, a-r, a*r を返します. r は a と同じタイプです.
   ** pos が false のときは a-b は定義されません.
   **/
  M opBinary(string op)(M r) if (op=="+"||!pos&&op=="-"||op=="*")
  { return opBinary!op(r.i); }
  /**
   ** a+=r, a-=r, a*=r を計算します. r は a と同じタイプです.
   ** pos が false のときは a-=b は定義されません.
   **/
  ref M opOpAssign(string op)(M r) if (op=="+"||!pos&&op=="-"||op=="*")
  { return opOpAssign!op(r.i); }

  /**
   ** a^^n を返します. 内部では繰り返し2乗法を使用しています.
   **/
  M opBinary(string op: "^^", T)(T n) if (isIntegral!T) { return this.powr(n); }

  static if (!pos) {
    /**
     ** a*r^{-1} を返します. r は a と同じタイプです.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    M opBinary(string op: "/")(M r) { return M(l*r.inv.i); }
    /**
     ** a*=r^{-1} を計算します. r は a と同じタイプです.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    ref M opOpAssign(string op: "/")(M r) { i = nm(l*r.inv.i); return this; }

    /**
     ** a*r^{-1} を返します. r は Integral です.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    M opBinary(string op: "/", T)(T r) if (isIntegral!T) { return opBinary!op(M(r)); }
    /**
     ** a*=r^{-1} を計算します. r は Integral です.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    M opOpAssign(string op: "/", T)(T r) if (isIntegral!T) { return opOpAssign!op(M(r)); }

    /**
     ** 自身の逆数を計算します.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    M inv() { int x = i, a, b; extGcd(x, m, a, b); return M(a); }
  }

  private
  {
    import std.traits;
    alias M = ModInt!(m, pos);
    version(BigEndian) union { long l; struct { int i2; int i; } } else union { long l; int i; }
    int nm(T)(T v) if (isIntegral!T)
    { static if (pos) return cast(int)(v%m); else return cast(int)((v%m+m)%m); }
  }
}
// ::::::::::::::::::::

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
