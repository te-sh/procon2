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
  version(BigEndian) union { long l; struct { int i2; int i; } } else union { long l; int i; }
  alias M = ModInt!(m, pos), Op = string;
  /**
   ** 剰余群の初期値 0 を返します.
   **/
  static init() { return M(0); }
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
   **/
  this(T)(T v = 0) { i = nm(v); }
  /**
   ** 自身に v から作成した剰余群を代入します.
   **/
  ref M opAssign(T)(T v) { i = nm(v); return this; }

  /**
   ** -a を返します.
   ** pos が true のときは定義されません.
   **/
  static if (!pos) pure M opUnary(Op op: "-")() { return M(-i); }

  static if (m < int.max / 2) {
    /**
     ** a+r, a-r を返します. r は int です.
     ** pos が false のときは a-b は定義されません.
     **/
    pure M opBinary(Op op)(int r) if(op=="+"||!pos&&op=="-") { return M(mixin("i"~op~"r")); }
    /**
     ** a+=r, a-=r を計算します. r は int です.
     ** pos が false のときは a-=b は定義されません.
     **/
    ref M opOpAssign(Op op)(int r) if(op=="+"||!pos&&op=="-") { i=nm(mixin("i"~op~"r")); return this; }
  } else {
    /**
     ** a+r, a-r を返します. r は int です.
     ** pos が false のときは a-b は定義されません.
     **/
    pure M opBinary(Op op)(int r) if(op=="+"||!pos&&op=="-") { return M(mixin("l"~op~"r")); }
    /**
     ** a+=r, a-=r を計算します. r は int です.
     ** pos が false のときは a-=b は定義されません.
     **/
    ref M opOpAssign(Op op)(int r) if(op=="+"||!pos&&op=="-") { i=nm(mixin("l"~op~"r")); return this; }
  }
  /**
   ** a*r を返します. r は int です.
   **/
  pure M opBinary(Op op: "*")(int r) { return M(l*r); }
  /**
   ** a*=r を計算します. r は int です.
   **/
  ref M opOpAssign(Op op: "*")(int r) { i=nm(l*r); return this; }

  /**
   ** a+r, a-r, a*r を返します. r は a と同じタイプです.
   ** pos が false のときは a-b は定義されません.
   **/
  pure M opBinary(Op op)(M r) if(op=="+"||!pos&&op=="-"||op=="*") { return opBinary!op(r.i); }
  /**
   ** a+=r, a-=r, a*=r を計算します. r は a と同じタイプです.
   ** pos が false のときは a-=b は定義されません.
   **/
  ref M opOpAssign(Op op)(M r) if(op=="+"||!pos&&op=="-"||op=="*") { return opOpAssign!op(r.i); }

  /**
   ** a^^n を返します. 内部では繰り返し2乗法を使用しています.
   **/
  pure M opBinary(Op op: "^^", T)(T n) { return this.powr(n); }

  static if (!pos) {
    /**
     ** a*r^{-1} を返します. r は a と同じタイプです.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     */
    pure M opBinary(Op op: "/")(M r) { return M(l*r.inv.i); }
    /**
     ** a*=r^{-1} を計算します. r は a と同じタイプです.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     */
    ref M opOpAssign(Op op: "/")(M r) { i=nm(l*r.inv.i); return this; }

    /**
     ** a*r^{-1} を返します. r は int です.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     */
    pure M opBinary(Op op: "/")(int r) { return opBinary!op(M(r)); }
    /**
     ** a*=r^{-1} を計算します. r は int です.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     */
    ref M opOpAssign(Op op: "/")(int r) { return opOpAssign!op(M(r)); }

    /**
     ** 自身の逆数を計算します.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     */
    pure M inv() { int x = i, a, b; extGcd(x, m, a, b); return M(a); }
  }

private:

  pure int nm(int v) { static if (pos) return v%m; else return (v%m+m)%m; }
  pure int nm(long v) { static if (pos) return cast(int)(v%m); else return cast(int)((v%m+m)%m); }
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
