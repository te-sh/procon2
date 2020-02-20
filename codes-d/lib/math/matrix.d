module lib.math.matrix;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.math.matrix
import lib.math.misc;

/**
 ** ベクトルを表します.
 **/
struct Vector(T)
{
  /**
   ** ベクトルの次元です.
   **/
  size_t n;
  /**
   ** ベクトルの要素を配列で返します.
   **/
  @property T[] array() { return a; }
  alias array this;

  pure nothrow @safe
  {
    /**
     ** n 次元の零ベクトルを返します.
     ** zero は加法単位元です.
     **/
    this(size_t n, T zero = T(0))
      in { assert(n > 0); }
    do
    {
      this.n = n; this.zero = zero;
      a = new T[](n);
      if (T.init != zero) a[] = zero;
    }
    /**
     ** 配列 b を元に作成したベクトルを返します.
     ** zero は加法単位元です.
     **/
    this(U)(U[] b, T zero = T(0))
      in { assert(b.length > 0); }
    do
    {
      n = b.length; this.zero = zero;
      static if (is(T == U)) {
        a = b;
      } else {
        a = new T[](n);
        foreach (i; 0..n) a[i] = b[i];
      }
    }

    /**
     ** 自身のコピーを返します.
     **/
    Vector!T dup()
    {
      auto b = Vector!T(n, zero);
      b[] = a[];
      return b;
    }

    /**
     ** v+b, v-b を返します. b はベクトルです.
     ** v と b の次元は同じである必要があります.
     **/
    Vector!T opBinary(string op)(Vector!T b)
      if (op == "+" || op == "-")
      in { assert(n == b.n); }
    do
    {
      auto x = Vector!T(n, zero);
      foreach (i; 0..n) x[i] = mixin("a[i]"~op~"b[i]");
      return x;
    }
    /**
     ** v+=b, v-=b を計算します. b はベクトルです.
     ** v と b の次元は同じである必要があります.
     **/
    ref Vector!T opOpAssign(string op)(Vector!T b)
      if (op == "+" || op == "-")
      in { assert(n == b.n); }
    do
    {
      foreach (i; 0..n) mixin("a[i]"~op~"=b[i];");
      return this;
    }
    /**
     ** v*b を返します. b は数値です.
     **/
    Vector!T opBinary(string op: "*", U)(U b)
      if (isNumeric!T)
    {
      auto x = Vector!T(n, zero);
      foreach (i; 0..n) x[i] = a[i]*b;
      return x;
    }
    /**
     ** v*=b を計算します. b は数値です.
     **/
    ref Vector!T opOpAssign(string op: "*", U)(U b)
      if (isNumeric!T)
    {
      foreach (i; 0..n) a[i] *= b;
      return this;
    }
    /**
     ** v と b の内積を返します.
     ** v と b の次元は同じである必要があります.
     **/
    T opBinary(string op: "*")(Vector!T b)
      in { assert(n == b.n); }
    do
    {
      auto x = zero;
      foreach (i; 0..n) x += a[i]*b[i];
      return x;
    }
  }

  private
  {
    T[] a;
    T zero;
  }
}

pure nothrow @safe
{
  /**
   ** 配列 a を元に作成したベクトルを返します.
   ** zero は加法単位元です.
   **/
  auto vector(T)(T[] a, T zero = T(0))
  {
    return Vector!T(a, zero);
  }
  /**
   ** ベクトル a 同士の内積を返します.
   **/
  T hypot2(T)(Vector!T a)
  {
    return a*a;
  }
  /**
   ** ベクトル a, b のクロス積を返します.
   ** a, b の次元は 3 である必要があります.
   **/
  pure Vector!T cross(T)(Vector!T a, Vector!T b)
    in { assert(a.n == 3 && b.n == 3); }
  do
  {
    return Vector!T([a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]], a.zero);
  }
}

/**
 ** 行列を表します.
 **/
struct Matrix(T)
{
  /**
   ** r は行列の行数, c は行列の列数です.
   **/
  size_t r, c;
  /**
   ** 行列の要素を配列で返します.
   **/
  @property T[][] array() { return a; }
  alias array this;

  pure nothrow @safe
  {
    /**
     ** n 行 n 列の単位行列を返します.
     ** zero は加法単位元, one は乗法単位元です.
     **/
    static Matrix!T unit(size_t n, T zero = T(0), T one = T(1))
      in { assert(n > 0); }
    do
    {
      auto r = Matrix!T(n, n, zero, one);
      foreach (i; 0..n) r[i][i] = one;
      return r;
    }

    /**
     ** r 行 c 列の空行列を返します.
     **/
    this(size_t r, size_t c, T zero = T(0), T one = T(1))
      in { assert(r > 0 && c > 0); }
    do
    {
      this.r = r; this.c = c; this.zero = zero; this.one = one;
      a = new T[][](r, c);
      if (T.init != zero) foreach (i; 0..r) a[i][] = zero;
    }
    /**
     ** 配列 b を元に作成した行列を返します.
     **/
    this(U)(U[][] b, T zero = T(0), T one = T(1))
      in { assert(b.length > 0 && b[0].length > 0 && b.all!(l => l.length == b[0].length)); }
    do
    {
      r = b.length; c = b[0].length; this.zero = zero; this.one = one;
      static if (is(T == U)) {
        a = b;
      } else {
        a = new T[][](r, c);
        foreach (i; 0..r) foreach (j; 0..c) a[i][j] = b[i][j];
      }
    }
    /**
     ** コピーコンストラクタです.
     **/
    this(ref return scope Matrix!T v)
    {
      r = v.r; c = v.c; a = v.a; zero = v.zero; one = v.one;
    }
    /**
     ** 自身のコピーを返します.
     **/
    Matrix!T dup()
    {
      auto b = Matrix!T(r, c, zero, one);
      foreach (i; 0..r) b[i][] = a[i][];
      return b;
    }

    /**
     ** 自身と b の要素がすべて一致するかどうかを返します. b は行列です.
     **/
    bool opEquals(Matrix!T b)
    {
      return r == b.r && c == b.c && zip(a, b.a).all!"a[0]==a[1]";
    }

    /**
     ** m+b, m-b を返します. b は行列です.
     ** m と b の行数, 列数は同じである必要があります.
     **/
    Matrix!T opBinary(string op)(Matrix!T b)
      if (op == "+" || op == "-")
      in { assert(r == b.r && c == b.c); }
    do
    {
      auto x = Matrix!T(r, c, zero, one);
      foreach (i; 0..r) foreach (j; 0..c) x[i][j] = mixin("a[i][j]"~op~"b[i][j]");
      return x;
    }
    /**
     ** m+=b, m-=b を計算します. b は行列です.
     ** m と b の行数, 列数は同じである必要があります.
     **/
    ref Matrix!T opOpAssign(string op)(Matrix!T b)
      if (op == "+" || op == "-")
      in { assert(r == b.r && c == b.c); }
    do
    {
      foreach (i; 0..r) foreach (j; 0..c) mixin("a[i][j]"~op~"=b[i][j];");
      return this;
    }
    /**
     ** m*b を返します. b は数値です.
     **/
    Matrix!T opBinary(string op: "*", U)(U b)
      if (isNumeric!U)
    {
      auto x = Matrix!T(r, c, zero, one);
      foreach (i; 0..r) foreach (j; 0..c) x[i][j] = a[i][j]*b;
      return x;
    }
    /**
     ** m*=b を計算します. b は数値です.
     **/
    ref Matrix!T opOpAssign(string op: "*", U)(U b)
      if (isNumeric!U)
    {
      foreach (i; 0..r) foreach (j; 0..c) a[i][j] *= b;
      return this;
    }
    /**
     ** m*b を返します. b は行列です.
     ** m の列数と b の行数は同じである必要があります.
     **/
    Matrix!T opBinary(string op: "*")(Matrix!T b)
      in { assert(c == b.r); }
    do
    {
      auto x = Matrix!T(r, b.c, zero, one);
      foreach (i; 0..r) foreach (j; 0..b.c) foreach (k; 0..c) x[i][j] += a[i][k]*b[k][j];
      return x;
    }
    /**
     ** m*=b を計算します. b は行列です.
     ** m の列数と b の行数は同じである必要があります.
     **/
    ref Matrix!T opOpAssign(string op: "*")(Matrix!T b)
      in { assert(c == b.r); }
    do
    {
      auto x = this*b;
      r = x.r; c = x.c; a = x.a;
      return this;
    }
    /**
     ** m*b を返します. b はベクトルです.
     ** m の列数と b の次元は同じである必要があります.
     **/
    Vector!T opBinary(string op: "*")(Vector!T b)
      in { assert(c == b.n); }
    do
    {
      auto x = Vector!T(r, zero);
      foreach (i; 0..r) foreach (j; 0..c) x[i] += a[i][j]*b[j];
      return x;
    }
    /**
     ** m^^b を返します. 内部では繰り返し2乗法を使用しています.
     ** m は正方行列である必要があります.
     **/
    Matrix!T opBinary(string op: "^^", U)(U n)
      if (isIntegral!U)
      in { assert(r == c); }
    do
    {
      return powr(this, n, Matrix!T.unit(r, zero, one));
    }
  }

  private
  {
    T[][] a;
    T zero, one;
  }
}

pure nothrow @safe
{
  /**
   ** 配列 a を元に作成したベクトルを返します.
   ** zero は加法単位元です.
   ** one は乗法単位元です.
   **/
  auto matrix(T)(T[][] a, T zero = T(0), T one = T(1))
  {
    return Matrix!T(a, zero, one);
  }

  /**
   ** 行列 a の行列式を返します.
   ** a は正方行列である必要があります.
   **/
  T det(T)(Matrix!T a)
    in { assert(a.r == a.c); }
  do
  {
    auto n = a.r, b = a.dup, d = a.one;

    foreach (i; 0..n) {
      auto p = i;
      foreach (j; i+1..n)
        if (b[p][i].abs < b[j][i].abs) p = j;
      swap(b[p], b[i]);
      foreach (j; i+1..n)
        foreach (k; i+1..n)
          b[j][k] -= b[i][k]*b[j][i]/b[i][i];
      d *= b[i][i];
      if (p != i) d = -d;
    }

    return d;
  }
}
// ::::::::::::::::::::

import lib.math.mod_int;

unittest
{
  auto a = Vector!int(2);
  a[0] = 1; a[1] = 2;
  assert(a == vector([1, 2]));
  auto b = vector([-3, 4]);

  assert(a.dup == vector([1, 2]));
  assert(a+b == vector([-2, 6]));
  assert(a-b == vector([4, -2]));
  assert(a*2 == vector([2, 4]));
  assert(a*b == 5);
  assert(a.hypot2 == 5);

  a = vector([1, 2]); a += b;
  assert(a == vector([-2, 6]));
  a = vector([1, 2]); a -= b;
  assert(a == vector([4, -2]));
  a = vector([1, 2]); a *= 2;
  assert(a == vector([2, 4]));

  alias mint = ModInt!7;
  auto c = Vector!mint([5, 18, -1]);
  assert(c == Vector!mint([5, 4, 6]));

  auto d = vector([2, 4, 5]), e = vector([1, 3, 2]);
  assert(cross(d, e) == vector([-7, 1, 2]));
}

unittest
{
  auto u = Matrix!int.unit(2);
  assert(matrix([[1, 0], [0, 1]]));

  auto a = Matrix!int(2, 2);
  a[0] = [1, -1]; a[1] = [-2, 3];
  auto b = matrix([[1, 2], [3, 4]]);

  assert(a.dup == matrix([[1, -1], [-2, 3]]));
  assert(a+b == matrix([[2, 1], [1, 7]]));
  assert(a-b == matrix([[0, -3], [-5, -1]]));
  assert(a*2 == matrix([[2, -2], [-4, 6]]));
  assert(a*b == matrix([[-2, -2], [7, 8]]));
  assert(a*vector([1, 2]) == vector([-1, 4]));
  assert(a^^3 == matrix([[11, -15], [-30, 41]]));

  a = matrix([[1, -1], [-2, 3]]); a += b;
  assert(a == matrix([[2, 1], [1, 7]]));
  a = matrix([[1, -1], [-2, 3]]); a -= b;
  assert(a == matrix([[0, -3], [-5, -1]]));
  a = matrix([[1, -1], [-2, 3]]); a *= 2;
  assert(a == matrix([[2, -2], [-4, 6]]));
  a = matrix([[1, -1], [-2, 3]]); a *= b;
  assert(a == matrix([[-2, -2], [7, 8]]));

  auto f = matrix!double([[3, 4, -1], [2, 5, -2], [1, 6, -4]]);
  assert(approxEqual(f.det, -7, 1e-7));

  alias mint = ModInt!7;
  auto c = Matrix!mint([[5, 18, -1], [2, -13, 8]]);
  assert(c == Matrix!mint([[5, 4, 6], [2, 1, 1]]));
}
