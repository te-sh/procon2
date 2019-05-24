struct Matrix(T)
{
  import std.algorithm, std.functional, std.traits;

  size_t r, c;
  T zero;
  T[][] a;
  alias a this;

  static auto unit(size_t n, T init = T(1))
  in { assert(n > 0); }
  body {
    auto r = Matrix!T(n, n);
    foreach (i; 0..n) r[i][i] = init;
    return r;
  }

  this(size_t r, size_t c, T zero = T(0))
  in { assert(r > 0 && c > 0); }
  body {
    this.r = r; this.c = c; this.zero = zero;
    a = new T[][](r, c);
    static if (T.init != 0) foreach (i; 0..r) a[i][] = zero;
  }

  this(T[][] b, T zero = T(0))
  in { assert(b.length > 0 && b[0].length > 0 && b.all!(l => l.length == b[0].length)); }
  body {
    r = b.length;
    c = b[0].length;
    this.zero = zero;
    a = b;
  }

  pure auto dup() { auto x = Matrix!T(r, c, zero); foreach (i; 0..r) x[i][] = a[i][]; return x; }

  pure auto opEquals(Matrix!T b)
  {
    if (r != b.r || c != b.c) return false;
    foreach (i; 0..r) if (a[i] != b[i]) return false;
    return true;
  }

  pure auto opBinary(string op)(Matrix!T b)
  if (op == "+" || op == "-")
  in { assert(r == b.r && c == b.c); }
  body {
    auto x = Matrix!T(r, c);
    foreach (i; 0..r) foreach (j; 0..c) x[i][j] = mixin("a[i][j]"~op~"b[i][j]");
    return x;
  }

  pure auto opBinary(string op: "*")(Matrix!T b)
  in { assert(c == b.r); }
  body {
    auto x = Matrix!T(r, b.c, zero);
    foreach (i; 0..r) foreach (j; 0..b.c) foreach (k; 0..c) x[i][j] += a[i][k]*b[k][j];
    return x;
  }

  pure auto opBinary(string op: "*")(T[] b)
  in { assert(c == b.length); }
  body {
    auto x = new T[](r);
    static if (T.init != 0) x[] = zero;
    foreach (i; 0..r) foreach (j; 0..c) x[i] += a[i][j]*b[j];
    return x;
  }

  pure auto opBinary(string op: "^^", U)(U n)
  if (isIntegral!U)
  in { assert(r == c); }
  body {
    auto x = Matrix!T.unit(r);
    if (n == 0) return x;

    auto b = dup;
    for (; n > 0; n >>= 1) {
      if (n&1) x = x*b;
      b = b*b;
    }

    return x;
  }
}
Matrix!T matrix(T)(T[][] a, T zero = T(0)) { return Matrix!T(a, zero); }

pure auto det(T)(Matrix!T a)
in { assert(a.r == a.c); }
body {
  import std.algorithm, std.math;

  auto n = a.r, b = a.dup, d = T(1);

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

  Matrix!T

    行列の構造体です.

  Matrix!T.unit(n)

    n * n の単位行列を返します.

  a.dup

    行列のコピーを返します.

  a == b

    行数, 列数およびすべての要素が一致しているかを返します.

  a + b

  Matrix!T b を足した結果の行列を返します.
    a, b の行数と列数は一致している必要があります.

  a - b

    Matrix!T b を引いた結果の行列を返します.
    a, b の行数と列数は一致している必要があります.

  a * b

    Matrix!T b を右から掛けた結果の行列を返します.
    a の列数と b の行数は一致している必要があります.

  a * b

    T[] b を列ベクトルとみなして右から掛けた結果の列ベクトルを配列で返します.
    a の列数と b の大きさは一致している必要があります.

  a ^^ n

    a の n 乗の行列を返します.
    a は正方行列である必要があります.
    内部では繰り返し2乗法を使っています.

  det(a)

    a の行列式を返します.
    a は正方行列である必要があります.

 */

unittest
{
  auto u = Matrix!int.unit(2);
  assert(u[0] == [1, 0] && u[1] == [0, 1]);

  auto a = Matrix!int(2, 2);
  a[0] = [1, -1]; a[1] = [-2, 3];
  auto b = matrix([[1, 2], [3, 4]]);

  auto c0 = a.dup;
  assert(c0 == matrix([[1, -1], [-2, 3]]));

  auto c1 = a + b;
  assert(c1 == matrix([[2, 1], [1, 7]]));

  auto c2 = a - b;
  assert(c2 == matrix([[0, -3], [-5, -1]]));

  auto c3 = a * b;
  assert(c3 == matrix([[-2, -2], [7, 8]]));

  auto c4 = a * [1, 2];
  assert(c4 == [-1, 4]);

  auto c5 = a ^^ 3;
  assert(c5 == matrix([[11, -15], [-30, 41]]));

  import std.math;
  auto f = matrix([[3.0, 4, -1], [2.0, 5, -2], [1.0, 6, -4]]);
  auto g = f.det;
  assert((g + 7).abs < 1e-7);
}
