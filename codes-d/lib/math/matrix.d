module lib.math.matrix;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.math.matrix
import lib.math.misc;

/**
 ** ベクトルを表します.
 ** zero は加法単位元です.
 **/
struct Vector(T, T zero = 0)
{
  alias V = Vector!(T, zero), Op = string;
  /**
   ** ベクトルの次元です.
   **/
  size_t n;
  /**
   ** ベクトルの要素を配列で返します.
   **/
  @property T[] array() { return a; }
  alias array this;

  /**
   ** n 次元の零ベクトルを返します.
   **/
  this(size_t n) in { assert(n > 0); } do
  {
    this.n = n;
    a = new T[](n);
    static if (T.init != zero) a[] = zero;
  }
  /**
   ** 配列 b を元に作成したベクトルを返します.
   **/
  this(U)(U[] b) in { assert(b.length > 0); } do
  {
    n = b.length;
    static if (is(T == U)) a = b;
    else { a = new T[](n); foreach (i; 0..n) a[i] = b[i]; }
  }

  /**
   ** 自身のコピーを返します.
   **/
  pure V dup() { auto b = V(n); b[] = a[]; return b; }

  /**
   ** v+b, v-b を返します. b はベクトルです.
   ** v と b の次元は同じである必要があります.
   **/
  pure V opBinary(Op op)(V b) if (op=="+"||op=="-") in { assert(n == b.n); } do
  {
    auto x = V(n);
    foreach (i; 0..n) x[i] = mixin("a[i]"~op~"b[i]");
    return x;
  }
  /**
   ** v+=b, v-=b を計算します. b はベクトルです.
   ** v と b の次元は同じである必要があります.
   **/
  ref V opOpAssign(Op op)(V b) if (op=="+"||op=="-") in { assert(n == b.n); } do
  {
    foreach (i; 0..n) mixin("a[i]"~op~"=b[i];");
    return this;
  }

  /**
   ** v*b を返します. b は数値です.
   **/
  pure V opBinary(Op op: "*")(T b)
  {
    auto x = V(n);
    foreach (i; 0..n) x[i] = a[i]*b;
    return x;
  }
  /**
   ** v*=b を計算します. b は数値です.
   **/
  ref V opOpAssign(Op op: "*")(T b)
  {
    foreach (i; 0..n) a[i] *= b;
    return this;
  }

  /**
   ** v と b の内積を返します.
   ** v と b の次元は同じである必要があります.
   **/
  pure T opBinary(Op op: "*")(V b) in { assert(n == b.n); } do
  {
    auto x = T(zero);
    foreach (i; 0..n) x += a[i]*b[i];
    return x;
  }

private:

  T[] a;
}
/**
 ** n 次元の空ベクトルを返します.
 ** zero は加法単位元です.
 **/
Vector!(T, zero) vector(T, T zero = 0)(T[] a)
{
  return Vector!(T, zero)(a);
}
/**
 ** 配列 b を元に作成したベクトルを返します.
 ** zero は加法単位元です.
 **/
Vector!(T, zero) vector(T, U, T zero = 0)(U[] a) if (!is(T == U))
{
  return Vector!(T, zero)(a);
}

/**
 ** ベクトル a 同士の内積を返します.
 **/
pure T hypot2(T, alias zero)(Vector!(T, zero) a) { return a*a; }

/**
 ** ベクトル a, b のクロス積を返します.
 ** a, b の次元は 3 である必要があります.
 **/
pure Vector!(T, zero) cross(T, alias zero)(Vector!(T, zero) a, Vector!(T, zero) b)
in { assert(a.n == 3 && b.n == 3); } do
{
  return Vector!(T, zero)([a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]]);
}

/**
 ** 行列を表します.
 ** zero は加法単位元です.
 ** one は乗法単位元です.
 **/
struct Matrix(T, T zero = 0, T one = 1)
{
  alias M = Matrix!(T, zero, one), V = Vector!(T, zero), Op = string;
  /**
   ** r は行列の行数, c は行列の列数です.
   **/
  size_t r, c;
  /**
   ** 行列の要素を配列で返します.
   **/
  @property T[][] array() { return a; }
  alias array this;

  /**
   ** n 行 n 列の単位行列を返します.
   **/
  static auto unit(size_t n) in { assert(n > 0); } do
  {
    auto r = M(n, n);
    foreach (i; 0..n) r[i][i] = one;
    return r;
  }

  /**
   ** r 行 c 列の空行列を返します.
   **/
  this(size_t r, size_t c) in { assert(r > 0 && c > 0); } do
  {
    this.r = r; this.c = c;
    a = new T[][](r, c);
    static if (T.init != zero) foreach (i; 0..r) a[i][] = zero;
  }
  /**
   ** 配列 b を元に作成した行列を返します.
   **/
  this(U)(U[][] b)
  in { assert(b.length > 0 && b[0].length > 0 && b.all!(l => l.length == b[0].length)); } do
  {
    r = b.length; c = b[0].length;
    static if (is(T == U)) a = b;
    else { a = new T[][](r, c); foreach (i; 0..r) foreach (j; 0..c) a[i][j] = b[i][j]; }
  }

  /**
   ** 自身のコピーを返します.
   **/
  pure M dup() { auto b = M(r, c); foreach (i; 0..r) b[i][] = a[i][]; return b; }

  /**
   ** 自身と b の要素がすべて一致するかどうかを返します. b は行列です.
   **/
  pure bool opEquals(M b)
  {
    return r == b.r && c == b.c && zip(a, b.a).all!"a[0]==a[1]";
  }

  /**
   ** m+b, m-b を返します. b は行列です.
   ** m と b の行数, 列数は同じである必要があります.
   **/
  pure M opBinary(Op op)(M b) if (op=="+"||op=="-") in { assert(r == b.r && c == b.c); } do
  {
    auto x = M(r, c);
    foreach (i; 0..r) foreach (j; 0..c) x[i][j] = mixin("a[i][j]"~op~"b[i][j]");
    return x;
  }
  /**
   ** m+=b, m-=b を計算します. b は行列です.
   ** m と b の行数, 列数は同じである必要があります.
   **/
  ref M opOpAssign(Op op)(M b) if (op=="+"||op=="-") in { assert(r == b.r && c == b.c); } do
  {
    foreach (i; 0..r) foreach (j; 0..c) mixin("a[i][j]"~op~"=b[i][j];");
    return this;
  }

  /**
   ** m*b を返します. b は数値です.
   **/
  pure M opBinary(Op op: "*")(T b)
  {
    auto x = M(r, c);
    foreach (i; 0..r) foreach (j; 0..c) x[i][j] = a[i][j]*b;
    return x;
  }
  /**
   ** m*=b を計算します. b は数値です.
   **/
  ref M opOpAssign(Op op: "*")(T b)
  {
    foreach (i; 0..r) foreach (j; 0..c) a[i][j] *= b;
    return this;
  }

  /**
   ** m*b を返します. b は行列です.
   ** m の列数と b の行数は同じである必要があります.
   **/
  pure M opBinary(Op op: "*")(M b) in { assert(c == b.r); } do
  {
    auto x = M(r, b.c);
    foreach (i; 0..r) foreach (j; 0..b.c) foreach (k; 0..c) x[i][j] += a[i][k]*b[k][j];
    return x;
  }
  /**
   ** m*=b を計算します. b は行列です.
   ** m の列数と b の行数は同じである必要があります.
   **/
  ref M opOpAssign(Op op: "*")(M b) in { assert(c == b.r); } do
  {
    auto x = this*b;
    r = x.r; c = x.c; a = x.a;
    return this;
  }

  /**
   ** m*b を返します. b はベクトルです.
   ** m の列数と b の次元は同じである必要があります.
   **/
  pure V opBinary(Op op: "*")(V b) in { assert(c == b.n); } do
  {
    auto x = V(b.n);
    foreach (i; 0..r) foreach (j; 0..c) x[i] += a[i][j]*b[j];
    return x;
  }

  /**
   ** m^^b を返します. 内部では繰り返し2乗法を使用しています.
   ** m は正方行列である必要があります.
   **/
  pure M opBinary(Op op: "^^", U)(U n) in { assert(r == c); } do
  {
    return powr(this, n, M.unit(r));
  }

private:

  T[][] a;
}
/**
 ** r 行 c 列の零行列を返します.
 ** zero は加法単位元です.
 ** one は乗法単位元です.
 **/
Matrix!(T, zero, one) matrix(T, T zero = 0, T one = 1)(T[][] a)
{
  return Matrix!(T, zero, one)(a);
}
/**
 ** 配列 b を元に作成した行列を返します.
 ** zero は加法単位元です.
 ** one は乗法単位元です.
 **/
Matrix!(T, zero, one) matrix(T, U, T zero = 0, T one = 1)(U[][] a) if (!is(T == U))
{
  return Matrix!(T, zero, one)(a);
}

/**
 ** 行列 a の行列式を返します.
 ** a は正方行列である必要があります.
 **/
pure T det(T, alias zero, alias one)(Matrix!(T, zero, one) a) in { assert(a.r == a.c); } do
{
  auto n = a.r, b = a.dup, d = one;

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
// ::::::::::::::::::::

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

  import lib.math.mod_int;
  alias mint = ModInt!7;
  auto c = vector!mint([5, 18, -1]);
  assert(c == vector!mint([5, 4, 6]));

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

  import lib.math.mod_int;
  alias mint = ModInt!7;
  auto c = matrix!mint([[5, 18, -1], [2, -13, 8]]);
  assert(c == matrix!mint([[5, 4, 6], [2, 1, 1]]));
}
