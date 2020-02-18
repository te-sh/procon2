module lib.math.matrix;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.math.matrix
import lib.math.misc;

/**
 ** ベクトル, 行列の要素の型情報を表します.
 ** zero は加法単位元です.
 ** one は乗法単位元です.
 **/
template MatrixElement(T, alias zero = 0, alias one = 1)
{
  /**
   ** ベクトルを表します.
   **/
  struct Vector
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
    pure Vector dup() { auto b = Vector(n); b[] = a[]; return b; }

    /**
     ** v+b, v-b を返します. b はベクトルです.
     ** v と b の次元は同じである必要があります.
     **/
    pure Vector opBinary(string op)(Vector b) if (op=="+"||op=="-") in { assert(n == b.n); } do
    { auto x = Vector(n); foreach (i; 0..n) x[i] = mixin("a[i]"~op~"b[i]"); return x; }
    /**
     ** v+=b, v-=b を計算します. b はベクトルです.
     ** v と b の次元は同じである必要があります.
     **/
    ref Vector opOpAssign(string op)(Vector b) if (op=="+"||op=="-") in { assert(n == b.n); } do
    { foreach (i; 0..n) mixin("a[i]"~op~"=b[i];"); return this; }
    /**
     ** v*b を返します. b は数値です.
     **/
    pure Vector opBinary(string op: "*")(T b)
    { auto x = Vector(n); foreach (i; 0..n) x[i] = a[i]*b; return x; }
    /**
     ** v*=b を計算します. b は数値です.
     **/
    ref Vector opOpAssign(string op: "*")(T b)
    { foreach (i; 0..n) a[i] *= b; return this; }

    /**
     ** v と b の内積を返します.
     ** v と b の次元は同じである必要があります.
     **/
    pure T opBinary(string op: "*")(Vector b) in { assert(n == b.n); } do
    { auto x = zero; foreach (i; 0..n) x += a[i]*b[i]; return x; }

    private T[] a;
  }

  /**
   ** ベクトル a 同士の内積を返します.
   **/
  pure T hypot2(Vector a) { return a*a; }
  /**
   ** ベクトル a, b のクロス積を返します.
   ** a, b の次元は 3 である必要があります.
   **/
  pure Vector cross(Vector a, Vector b) in { assert(a.n == 3 && b.n == 3); } do
  { return Vector([a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]]); }

  /**
   ** 行列を表します.
   **/
  struct Matrix
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

    /**
     ** n 行 n 列の単位行列を返します.
     **/
    static Matrix unit(size_t n) in { assert(n > 0); } do
    { auto r = Matrix(n, n); foreach (i; 0..n) r[i][i] = one; return r; }

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
    pure Matrix dup() { auto b = Matrix(r, c); foreach (i; 0..r) b[i][] = a[i][]; return b; }

    /**
     ** 自身と b の要素がすべて一致するかどうかを返します. b は行列です.
     **/
    pure bool opEquals(Matrix b)
    {
      return r == b.r && c == b.c && zip(a, b.a).all!"a[0]==a[1]";
    }

    /**
     ** m+b, m-b を返します. b は行列です.
     ** m と b の行数, 列数は同じである必要があります.
     **/
    pure Matrix opBinary(string op)(Matrix b) if (op=="+"||op=="-") in { assert(r == b.r && c == b.c); } do
    {
      auto x = Matrix(r, c);
      foreach (i; 0..r) foreach (j; 0..c) x[i][j] = mixin("a[i][j]"~op~"b[i][j]");
      return x;
    }
    /**
     ** m+=b, m-=b を計算します. b は行列です.
     ** m と b の行数, 列数は同じである必要があります.
     **/
    ref Matrix opOpAssign(string op)(Matrix b) if (op=="+"||op=="-") in { assert(r == b.r && c == b.c); } do
    {
      foreach (i; 0..r) foreach (j; 0..c) mixin("a[i][j]"~op~"=b[i][j];");
      return this;
    }

    /**
     ** m*b を返します. b は数値です.
     **/
    pure Matrix opBinary(string op: "*")(T b)
    {
      auto x = Matrix(r, c);
      foreach (i; 0..r) foreach (j; 0..c) x[i][j] = a[i][j]*b;
      return x;
    }
    /**
     ** m*=b を計算します. b は数値です.
     **/
    ref Matrix opOpAssign(string op: "*")(T b)
    {
      foreach (i; 0..r) foreach (j; 0..c) a[i][j] *= b;
      return this;
    }

    /**
     ** m*b を返します. b は行列です.
     ** m の列数と b の行数は同じである必要があります.
     **/
    pure Matrix opBinary(string op: "*")(Matrix b) in { assert(c == b.r); } do
    {
      auto x = Matrix(r, b.c);
      foreach (i; 0..r) foreach (j; 0..b.c) foreach (k; 0..c) x[i][j] += a[i][k]*b[k][j];
      return x;
    }
    /**
     ** m*=b を計算します. b は行列です.
     ** m の列数と b の行数は同じである必要があります.
     **/
    ref Matrix opOpAssign(string op: "*")(Matrix b) in { assert(c == b.r); } do
    {
      auto x = this*b;
      r = x.r; c = x.c; a = x.a;
      return this;
    }

    /**
     ** m*b を返します. b はベクトルです.
     ** m の列数と b の次元は同じである必要があります.
     **/
    pure Vector opBinary(string op: "*")(Vector b) in { assert(c == b.n); } do
    {
      auto x = Vector(r);
      foreach (i; 0..r) foreach (j; 0..c) x[i] += a[i][j]*b[j];
      return x;
    }

    /**
     ** m^^b を返します. 内部では繰り返し2乗法を使用しています.
     ** m は正方行列である必要があります.
     **/
    pure Matrix opBinary(string op: "^^", U)(U n) in { assert(r == c); } do
    {
      return powr(this, n, Matrix.unit(r));
    }

    private T[][] a;
  }

  /**
   ** 行列 a の行列式を返します.
   ** a は正方行列である必要があります.
   **/
  pure T det(Matrix a) in { assert(a.r == a.c); } do
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
}
// ::::::::::::::::::::

unittest
{
  alias me = MatrixElement!int, Vector = me.Vector;
  auto a = Vector(2);
  a[0] = 1; a[1] = 2;
  assert(a == Vector([1, 2]));
  auto b = Vector([-3, 4]);

  assert(a.dup == Vector([1, 2]));
  assert(a+b == Vector([-2, 6]));
  assert(a-b == Vector([4, -2]));
  assert(a*2 == Vector([2, 4]));
  assert(a*b == 5);
  assert(me.hypot2(a) == 5);

  a = Vector([1, 2]); a += b;
  assert(a == Vector([-2, 6]));
  a = Vector([1, 2]); a -= b;
  assert(a == Vector([4, -2]));
  a = Vector([1, 2]); a *= 2;
  assert(a == Vector([2, 4]));

  import lib.math.mod_int;
  alias mint = ModInt!7, mem = MatrixElement!(mint, mint(0), mint(1)), Vectorm = mem.Vector;
  auto c = Vectorm([5, 18, -1]);
  assert(c == Vectorm([5, 4, 6]));

  auto d = Vector([2, 4, 5]), e = Vector([1, 3, 2]);
  assert(me.cross(d, e) == Vector([-7, 1, 2]));
}

unittest
{
  alias me = MatrixElement!int, Matrix = me.Matrix, Vector = me.Vector;
  auto u = Matrix.unit(2);
  assert(Matrix([[1, 0], [0, 1]]));

  auto a = Matrix(2, 2);
  a[0] = [1, -1]; a[1] = [-2, 3];
  auto b = Matrix([[1, 2], [3, 4]]);

  assert(a.dup == Matrix([[1, -1], [-2, 3]]));
  assert(a+b == Matrix([[2, 1], [1, 7]]));
  assert(a-b == Matrix([[0, -3], [-5, -1]]));
  assert(a*2 == Matrix([[2, -2], [-4, 6]]));
  assert(a*b == Matrix([[-2, -2], [7, 8]]));
  assert(a*Vector([1, 2]) == Vector([-1, 4]));
  assert(a^^3 == Matrix([[11, -15], [-30, 41]]));

  a = Matrix([[1, -1], [-2, 3]]); a += b;
  assert(a == Matrix([[2, 1], [1, 7]]));
  a = Matrix([[1, -1], [-2, 3]]); a -= b;
  assert(a == Matrix([[0, -3], [-5, -1]]));
  a = Matrix([[1, -1], [-2, 3]]); a *= 2;
  assert(a == Matrix([[2, -2], [-4, 6]]));
  a = Matrix([[1, -1], [-2, 3]]); a *= b;
  assert(a == Matrix([[-2, -2], [7, 8]]));

  alias med = MatrixElement!(double, 0.0, 1.0), Matrixd = med.Matrix;
  auto f = Matrixd([[3, 4, -1], [2, 5, -2], [1, 6, -4]]);
  assert(approxEqual(med.det(f), -7, 1e-7));

  import lib.math.mod_int;
  alias mint = ModInt!7, mem = MatrixElement!(mint, mint(0), mint(1)), Matrixm = mem.Matrix;
  auto c = Matrixm([[5, 18, -1], [2, -13, 8]]);
  assert(c == Matrixm([[5, 4, 6], [2, 1, 1]]));
}
