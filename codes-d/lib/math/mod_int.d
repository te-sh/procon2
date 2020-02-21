module lib.math.mod_int;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.math.mod_int
import lib.math.powr;

import lib.math.misc;

/**
 ** m を法とする剰余群を表します.
 ** pos が true のときは内部が負になる状態を扱わない分高速化しますが, 一部の演算子は定義されません.
 **/
struct ModInt(int m, bool pos = false)
{
  pure nothrow @nogc @safe:
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
  this(T)(T v)
    if (isIntegral!T)
  {
    i = nm(v);
  }
  /**
   ** 自身に v から作成した剰余群を代入します.
   ** v は Integral です.
   **/
  ref Mint opAssign(T)(T v)
    if (isIntegral!T)
  {
    i = nm(v);
    return this;
  }
  /**
   ** 自身に v を代入します.
   ** v は同じタイプです.
   **/
  ref Mint opAssign(Mint v)
  {
    i = v.i;
    return this;
  }

  /**
   ** -a を返します.
   ** pos が true のときは定義されません.
   **/
  static if (!pos) {
    Mint opUnary(string op: "-")() const
    {
      return Mint(-i);
    }
  }

  static if (m < int.max / 2) {
    /**
     ** a+r, a-r を返します. r は Integral です.
     ** pos が false のときは a-b は定義されません.
     **/
    Mint opBinary(string op, T)(T r) const
      if ((op == "+" || (!pos && op == "-")) && isIntegral!T)
    {
      return Mint(mixin("i"~op~"r"));
    }
    /**
     ** a+=r, a-=r を計算します. r は Integral です.
     ** pos が false のときは a-=b は定義されません.
     **/
    ref Mint opOpAssign(string op, T)(T r)
      if ((op == "+" || (!pos && op == "-")) && isIntegral!T)
    {
      i = nm(mixin("i"~op~"r"));
      return this;
    }
  } else {
    /**
     ** a+r, a-r を返します. r は Integral です.
     ** pos が false のときは a-b は定義されません.
     **/
    Mint opBinary(string op, T)(T r) const
      if ((op == "+" || (!pos && op == "-")) && isIntegral!T)
    {
      return Mint(mixin("l"~op~"r"));
    }
    /**
     ** a+=r, a-=r を計算します. r は int です.
     ** pos が false のときは a-=b は定義されません.
     **/
    ref Mint opOpAssign(string op, T)(T r)
      if ((op == "+" || (!pos && op == "-")) && isIntegral!T)
    {
      i = nm(mixin("l"~op~"r"));
      return this;
    }
  }
  /**
   ** a*r を返します. r は Integral です.
   **/
  Mint opBinary(string op: "*", T)(T r) const
    if (isIntegral!T)
  {
    return Mint(l*r);
  }
  /**
   ** a*=r を計算します. r は Integral です.
   **/
  ref Mint opOpAssign(string op: "*", T)(T r)
    if (isIntegral!T)
  {
    i = nm(l*r);
    return this;
  }

  /**
   ** a+r, a-r, a*r を返します. r は a と同じタイプです.
   ** pos が false のときは a-b は定義されません.
   **/
  Mint opBinary(string op)(Mint r) const
    if (op == "+" || !pos && op == "-" || op == "*")
  {
    return opBinary!op(r.i);
  }
  /**
   ** a+=r, a-=r, a*=r を計算します. r は a と同じタイプです.
   ** pos が false のときは a-=b は定義されません.
   **/
  ref Mint opOpAssign(string op)(Mint r)
    if (op == "+"|| !pos && op == "-" || op == "*")
  {
    return opOpAssign!op(r.i);
  }

  /**
   ** a^^n を返します. 内部では繰り返し2乗法を使用しています.
   **/
  Mint opBinary(string op: "^^", T)(T n)
    if (isIntegral!T)
  {
    return powr(this, n, Mint(1));
  }

  static if (!pos) {
    /**
     ** a*r^{-1} を返します. r は a と同じタイプです.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    Mint opBinary(string op: "/")(Mint r) const
    {
      return Mint(l*r.inv.i);
    }
    /**
     ** a*=r^{-1} を計算します. r は a と同じタイプです.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    ref Mint opOpAssign(string op: "/")(Mint r)
    {
      i = nm(l*r.inv.i);
      return this;
    }

    /**
     ** a*r^{-1} を返します. r は Integral です.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    Mint opBinary(string op: "/", T)(T r) const
      if (isIntegral!T)
    {
      return opBinary!op(Mint(r));
    }
    /**
     ** a*=r^{-1} を計算します. r は Integral です.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    Mint opOpAssign(string op: "/", T)(T r)
      if (isIntegral!T)
    {
      return opOpAssign!op(Mint(r));
    }

    /**
     ** 自身の逆数を計算します.
     ** m が素数でない場合は正しい値を返しません.
     ** pos が false のときは定義されません.
     **/
    Mint inv() const
    {
      return Mint(extGcd(i, m).x);
    }
  }

  private
  {
    alias Mint = ModInt!(m, pos);
    version(BigEndian) union { long l; struct { int i2; int i; } }
    else union { long l; int i; }

    pure nothrow @nogc @safe
    {
      int nm(T)(T v) const
        if (isIntegral!T)
      {
        static if (pos) return cast(int)(v%m);
        else return cast(int)pmod(v, m);
      }
    }
  }
}
// ::::::::::::::::::::

unittest
{
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
