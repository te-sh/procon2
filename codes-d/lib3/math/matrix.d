import misc;

struct Vector(T, T zero = 0)
{
  alias V = Vector!(T, zero), Op = string;
  size_t n;
  T[] a;
  alias a this;

  this(size_t n) in { assert(n > 0); } do
  {
    this.n = n;
    a = new T[](n);
    static if (T.init != zero) a[] = zero;
  }
  this(U)(U[] b) in { assert(b.length > 0); } do
  {
    n = b.length;
    static if (is(T == U)) a = b;
    else { a = new T[](n); foreach (i; 0..n) a[i] = b[i]; }
  }

  pure V dup() { auto b = V(n); b[] = a[]; return b; }

  pure V opBinary(Op op)(V b) if (op=="+"||op=="-") in { assert(n == b.n); } do
  {
    auto x = V(n);
    foreach (i; 0..n) x[i] = mixin("a[i]"~op~"b[i]");
    return x;
  }
  ref V opOpAssign(Op op)(V b) if (op=="+"||op=="-") in { assert(n == b.n); } do
  {
    foreach (i; 0..n) mixin("a[i]"~op~"=b[i];");
    return this;
  }

  pure V opBinary(Op op: "*")(T b)
  {
    auto x = V(n);
    foreach (i; 0..n) x[i] = a[i]*b;
    return x;
  }
  ref V opOpAssign(Op op: "*")(T b)
  {
    foreach (i; 0..n) a[i] *= b;
    return this;
  }

  pure T opBinary(Op op: "*")(V b) in { assert(n == b.n); } do
  {
    auto x = T(zero);
    foreach (i; 0..n) x += a[i]*b[i];
    return x;
  }
}
Vector!(T, zero) vector(T, T zero = 0)(T[] a)
{
  return Vector!(T, zero)(a);
}
Vector!(T, zero) vector(T, U, T zero = 0)(U[] a) if (!is(T == U))
{
  return Vector!(T, zero)(a);
}

pure T hypot2(T, alias zero)(Vector!(T, zero) a) { return a*a; }

pure Vector!(T, zero) outerProd(T, alias zero)(Vector!(T, zero) a, Vector!(T, zero) b)
in { assert(a.n == 3 && b.n == 3); } do
{
  return Vector!(T, zero)([a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]]);
}

struct Matrix(T, T zero = 0, T one = 1)
{
  import std.algorithm, std.range;
  alias M = Matrix!(T, zero, one), V = Vector!(T, zero), Op = string;
  size_t r, c;
  T[][] a;
  alias a this;

  static auto unit(size_t n) in { assert(n > 0); } do
  {
    auto r = M(n, n);
    foreach (i; 0..n) r[i][i] = one;
    return r;
  }

  this(size_t r, size_t c) in { assert(r > 0 && c > 0); } do
  {
    this.r = r; this.c = c;
    a = new T[][](r, c);
    static if (T.init != zero) foreach (i; 0..r) a[i][] = zero;
  }
  this(U)(U[][] b)
  in { assert(b.length > 0 && b[0].length > 0 && b.all!(l => l.length == b[0].length)); } do
  {
    r = b.length; c = b[0].length;
    static if (is(T == U)) a = b;
    else { a = new T[][](r, c); foreach (i; 0..r) foreach (j; 0..c) a[i][j] = b[i][j]; }
  }

  pure M dup() { auto b = M(r, c); foreach (i; 0..r) b[i][] = a[i][]; return b; }

  pure bool opEquals(M b)
  {
    return r == b.r && c == b.c && zip(a, b).all!"a[0]==a[1]";
  }

  pure M opBinary(Op op)(M b) if (op=="+"||op=="-") in { assert(r == b.r && c == b.c); } do
  {
    auto x = M(r, c);
    foreach (i; 0..r) foreach (j; 0..c) x[i][j] = mixin("a[i][j]"~op~"b[i][j]");
    return x;
  }
  ref M opOpAssign(Op op)(M b) if (op=="+"||op=="-") in { assert(r == b.r && c == b.c); } do
  {
    foreach (i; 0..r) foreach (j; 0..c) mixin("a[i][j]"~op~"=b[i][j];");
    return this;
  }

  pure M opBinary(Op op: "*")(T b)
  {
    auto x = M(r, c);
    foreach (i; 0..r) foreach (j; 0..c) x[i][j] = a[i][j]*b;
    return x;
  }
  ref M opOpAssign(Op op: "*")(T b)
  {
    foreach (i; 0..r) foreach (j; 0..c) a[i][j] *= b;
    return this;
  }

  pure M opBinary(Op op: "*")(M b) in { assert(c == b.r); } do
  {
    auto x = M(r, b.c);
    foreach (i; 0..r) foreach (j; 0..b.c) foreach (k; 0..c) x[i][j] += a[i][k]*b[k][j];
    return x;
  }
  ref M opOpAssign(Op op: "*")(M b) in { assert(c == b.r); } do
  {
    auto x = this*b;
    r = x.r; c = x.c; a = x.a;
    return this;
  }

  pure V opBinary(Op op: "*")(V b) in { assert(c == b.n); } do
  {
    auto x = V(b.n);
    foreach (i; 0..r) foreach (j; 0..c) x[i] += a[i][j]*b[j];
    return x;
  }

  pure M opBinary(Op op: "^^", U)(U n) in { assert(r == c); } do
  {
    return powr(this, n, M.unit(r));
  }
}
Matrix!(T, zero, one) matrix(T, T zero = 0, T one = 1)(T[][] a)
{
  return Matrix!(T, zero, one)(a);
}
Matrix!(T, zero, one) matrix(T, U, T zero = 0, T one = 1)(U[][] a) if (!is(T == U))
{
  return Matrix!(T, zero, one)(a);
}

pure T det(T, alias zero, alias one)(Matrix!(T, zero, one) a) in { assert(a.r == a.c); } do
{
  import std.algorithm, std.math;
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

/*

  struct Vector(T, T zero = 0)

    ベクトルを表します.
    zero には加法単位元を指定します.

    Vector!(T, zero)(size_t n)

      n 次元零ベクトルを返します.

    Vector!(T, U, zero)(U[] b)

      b を元にしたベクトルを返します.

    pure Vector!(T, zero) dup()

      ベクトルのコピーを返します.

    a + b
    a - b

      ベクトル同士の加減算の結果を返します.
      両者の次元は一致している必要があります.

    a * b

      ベクトル a とスカラー b の乗算の結果を返します.

    a * b

      ベクトル a とベクトル b の内積を返します.
      両者の次元は一致している必要があります.

    a += b
    a -= b

      ベクトル同士の加減算を行います.
      次元は一致している必要があります.

    a *= b

      ベクトル a にスカラー b を乗算します.

    pure T hypot2()

      自身同士の内積を返します.

    pure Vector!(T, zero) outerProd(Vector!(T, zero) b)

      ベクトル a とベクトル b のクロス積 (外積) を返します.

  Vector!(T, zero) vector(T, T zero = 0)(T[] a)
  Vector!(T, zero) vector(T, U, T zero = 0)(U[] a)

    a を元にしたベクトルを返します.
    zero には加法単位元を指定します.

  struct Matrix(T, T zero = 0, T one = 1)

    行列を表します.
    zero には加法単位元を指定します.
    one には乗法単位元を指定します.

    static unit(size_t n)

      n 行 n 列の単位行列を返します.

    Matrix!(T, zero, one)(size_t r, size_t c)

      r 行 c 列の零ベクトルを返します.

    Matrix!(T, U, zero, one)(U[] b)

      b を元にした行列を返します.

    pure Matrix!(T, zero, one) dup()

      行列のコピーを返します.

    a == b

      行数, 列数およびすべての要素が一致しているかを返します.

    a + b
    a - b

      行列同士の加減算の結果を返します.
      両者の行数および列数は一致している必要があります.

    a * b

      行列 a とスカラー b の乗算の結果を返します.

    a * b

      行列 a に行列 b を右から乗算した結果の行列を返します.
      a の列数と b の行数は一致している必要があります.

    a * b

      行列 a にベクトル b を右から掛けた結果のベクトルを返します.
      a の列数と b の次元は一致している必要があります.

    a ^^ n

      行列 a の n 乗の行列を返します.
      a は正方行列である必要があります.
      内部では繰り返し2乗法を使っています.

    a += b
    a -= b

      行列同士の加減算を行います.
      両者の行数および列数は一致している必要があります.

    a *= b

      行列 a にスカラー b を乗算します.

    a *= b

      行列 a に行列 b を右から乗算します.
      a の列数と b の行数は一致している必要があります.

    pure T det()

      行列式を返します.
      行列は正方行列である必要があります.

  Matrix!(T, zero, one) matrix(T, T zero = 0, T one = 1)(T[][] a)
  Matrix!(T, zero, one) matrix(T, U, T zero = 0, T one = 1)(U[][] a)

    a を元にした行列を返します.
    zero には加法単位元を指定します.
    one には乗法単位元を指定します.

*/

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

  import mod_int;
  alias mint = ModInt!7;
  auto c = vector!mint([5, 18, -1]);
  assert(c == vector!mint([5, 4, 6]));

  auto d = vector([2, 4, 5]), e = vector([1, 3, 2]);
  assert(outerProd(d, e) == vector([-7, 1, 2]));
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

  import std.math;
  auto f = matrix!double([[3, 4, -1], [2, 5, -2], [1, 6, -4]]);
  assert(approxEqual(f.det, -7, 1e-7));

  import mod_int;
  alias mint = ModInt!7;
  auto c = matrix!mint([[5, 18, -1], [2, -13, 8]]);
  assert(c == matrix!mint([[5, 4, 6], [2, 1, 1]]));
}
