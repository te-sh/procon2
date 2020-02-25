module lib.math.mod_int2;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.math.mod_int2
import lib.math.powr;

import lib.math.misc;

/**
 ** m を法とする剰余群を表します.
 **/
struct ModInt(int m)
{
  pure nothrow @nogc @safe
  {
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
     ** コピーコンストラクタです.
     **/
    this(ref return scope const Mint v)
    {
      i = v.i;
    }
    /**
     ** g == v かどうかを返します.
     ** v は Integral か ModInt です.
     **/
    bool opEquals(T)(T v) const
      if (isIntegral!T)
    {
      return i == v;
    }
    /// ditto
    bool opEquals(const Mint v) const
    {
      return i == v.i;
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
    ref Mint opAssign(const Mint v)
    {
      i = v.i;
      return this;
    }

    /**
     ** -a を返します.
     **/
    Mint opUnary(string op: "-")() const
    {
      return Mint(-i);
    }

    static if (m < int.max/2) {
      /**
       ** a+r を返します. r は int か ModInt です.
       **/
      Mint opBinary(string op: "+")(int r) const
      {
        auto m = Mint.init;
        m.i = nm(i+r);
        return m;
      }
      /// ditto
      Mint opBinary(string op: "+")(const Mint r) const
      {
        auto m = Mint.init;
        m.i = nmp(i+r.i);
        return m;
      }
      /**
       ** a+=r を計算します. r は int か ModInt です.
       **/
      ref Mint opOpAssign(string op: "+")(int r)
      {
        i = nm(i+r);
        return this;
      }
      /// ditto
      ref Mint opOpAssign(string op: "+")(const Mint r)
      {
        i = nmp(i+r.i);
        return this;
      }
    } else {
      /**
       ** a+r を返します. r は int か ModInt です.
       **/
      Mint opBinary(string op: "+")(int r) const
      {
        auto m = Mint.init;
        m.i = nm(l+r);
        return m;
      }
      /// ditto
      Mint opBinary(string op: "+")(const Mint r) const
      {
        auto m = Mint.init;
        m.i = nmp(l+r.i);
        return m;
      }
      /**
       ** a+=r を計算します. r は int か ModInt です.
       **/
      ref Mint opOpAssign(string op: "+")(int r)
      {
        i = nm(l+r);
        return this;
      }
      /// ditto
      ref Mint opOpAssign(string op: "+")(const Mint r)
      {
        i = nmp(l+r.i);
        return this;
      }
    }
    /**
     ** a-r を返します. r は int か ModInt です.
     **/
    Mint opBinary(string op: "-")(int r) const
    {
      return Mint(i-r);
    }
    /// ditto
    Mint opBinary(string op: "-")(const Mint r) const
    {
      return Mint(i-r.i);
    }
    /**
     ** a-=r を計算します. r は int か ModInt です.
     **/
    ref Mint opOpAssign(string op: "-")(int r)
    {
      i = nm(i-r);
      return this;
    }
    /// ditto
    ref Mint opOpAssign(string op: "-")(const Mint r)
    {
      i = nm(i-r.i);
      return this;
    }

    /**
     ** a+r, a-r を返します. r は int 以外の Integral です.
     **/
    Mint opBinary(string op, T)(T r) const
      if ((op == "+" || op == "-") && isIntegral!T && !is(T == int))
    {
      return Mint(mixin("l"~op~"r"));
    }
    /**
     ** a+=r, a-=r を返します. r は int 以外の Integral です.
     **/
    ref Mint opOpAssign(string op, T)(T r)
      if ((op == "+" || op == "-") && isIntegral!T && !is(T == int))
    {
      i = nm(mixin("l"~op~"r"));
      return this;
    }

    /**
     ** a*r を返します. r は Integral か ModInt です.
     **/
    Mint opBinary(string op: "*", T)(T r) const
      if (isIntegral!T)
    {
      auto m = Mint.init;
      m.i = nm(l*r);
      return m;
    }
    /// ditto
    Mint opBinary(string op: "*")(const Mint r) const
    {
      auto m = Mint.init;
      m.i = nmp(l*r.i);
      return m;
    }
    /**
     ** a*=r を計算します. r は Integral か ModInt です.
     **/
    ref Mint opOpAssign(string op: "*", T)(T r)
      if (isIntegral!T)
    {
      i = nm(l*r);
      return this;
    }
    /// ditto
    ref Mint opOpAssign(string op: "*")(const Mint r)
    {
      i = nmp(l*r.i);
      return this;
    }

    /**
     ** ++a を計算します.
     **/
    ref Mint opUnary(string op: "++")()
    {
      i = nmp(i+1);
      return this;
    }
    /**
     ** --a を計算します.
     **/
    ref Mint opUnary(string op: "--")()
    {
      i = nm(i-1);
      return this;
    }

    /**
     ** a^^n を返します. 内部では繰り返し2乗法を使用しています.
     **/
    Mint opBinary(string op: "^^", T)(T n)
      if (isIntegral!T)
    {
      return powr(this, n, Mint(1));
    }

    /**
     ** a*r^{-1} を返します. r は ModInt です.
     ** m が素数でない場合は正しい値を返しません.
     **/
    Mint opBinary(string op: "/")(const Mint r) const
    {
      return Mint(l*r.inv.i);
    }
    /**
     ** a*=r^{-1} を計算します. r は ModInt です.
     ** m が素数でない場合は正しい値を返しません.
     **/
    ref Mint opOpAssign(string op: "/")(const Mint r)
    {
      i = nm(l*r.inv.i);
      return this;
    }

    /**
     ** a*r^{-1} を返します. r は Integral です.
     ** m が素数でない場合は正しい値を返しません.
     **/
    Mint opBinary(string op: "/", T)(T r) const
      if (isIntegral!T)
    {
      return opBinary!op(Mint(r));
    }
    /**
     ** a*=r^{-1} を計算します. r は Integral です.
     ** m が素数でない場合は正しい値を返しません.
     **/
    ref Mint opOpAssign(string op: "/", T)(T r)
      if (isIntegral!T)
    {
      return opOpAssign!op(Mint(r));
    }

    /**
     ** 自身の逆数を計算します.
     ** m が素数でない場合は正しい値を返しません.
     **/
    Mint inv() const
    {
      return Mint(extGcd(i, m).x);
    }
  }

  pure nothrow @safe
  {
    /**
     ** 文字列に変換した値を返します.
     **/
    string toString() const
    {
      return i.to!string;
    }
  }

  private
  {
    alias Mint = ModInt!m;
    version(BigEndian) union { long l; struct { int i2; int i; } }
    else union { long l; int i; }

    pragma(inline) pure nothrow @nogc @safe
    {
      int nm(T)(T v) const
        if (isIntegral!T)
      {
        return cast(int)pmod(v, m);
      }

      int nmp(T)(T v) const
        if (isIntegral!T)
      {
        return cast(int)(v%m);
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
  assert(a+19L == 1);
  assert(a-19 == 5);
  assert(a-19L == 5);
  assert(a*19 == 1);
  assert(a*19L == 1);
  assert(a^^3 == 6);
  assert(a/b == 2);
  assert(b.inv == 3);

  a = 18; a += b;
  assert(a == 2);
  a = 18; a += 5;
  assert(a == 2);
  a = 18; a += 5L;
  assert(a == 2);
  a = 18; a -= b;
  assert(a == 6);
  a = 18; a -= 5;
  assert(a == 6);
  a = 18; a -= 5L;
  assert(a == 6);
  a = 18; a *= b;
  assert(a == 6);
  a = 18; a *= 5;
  assert(a == 6);
  a = 18; a *= 5L;
  assert(a == 6);
  a = 18; a /= b;
  assert(a == 5);
  a = 18; a /= 5;
  assert(a == 5);
  a = 18; a /= 5L;
  assert(a == 5);
  a = 18; ++a;
  assert(a == 5);
  a = 18; --a;
  assert(a == 3);

  auto e = a; e += 5;
  assert(a == 3);
  assert(e == 1);

  e = b; e += 5;
  assert(b == 5);
  assert(e == 3);
}
