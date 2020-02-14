module lib.data_structure.grid;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.data_structure.grid
class Grid(T)
{
  import std.format, std.traits;

  /**
   ** 位置を表します.
   **/
  class Pos
  {
    /**
     ** 行, 列の値です.
     **/
    int r, c;
    /**
     ** 行 r, 列 c の位置を作成します.
     **/
    this(int r, int c) { this.r = r; this.c = c; }
    /**
     ** 文字列に変換したものを返します.
     **/
    pure override string toString() { return format("(%d, %d)", r, c); }
    /**
     ** p==q かどうかを返します.
     **/
    pure override bool opEquals(Object q) { return r == (cast(Pos)q).r && c == (cast(Pos)q).c; }
    /**
     ** 位置がグリッド内かどうかを返します.
     **/
    pure bool inGrid() { return 0 <= r && r < h && 0 <= c && c < w; }
    /**
     ** 1次元で考えたときのインデックスを返します.
     **/
    pure int p2i() { return cast(int)w*r+c; }

    /**
     ** p, q をベクトルとして, p+q, p-q を返します.
     **/
    pure Pos opBinary(string op, U)(U q) if (op=="+"||op=="-")
    { return mixin("pos(r"~op~"q.r, c"~op~"q.c)"); }
    /**
     ** p, q をベクトルとして, p+=q, p-=q を計算します.
     **/
    Pos opOpAssign(string op, U)(U q) if (op=="+"||op=="-")
    { mixin("r"~op~"=q.r; c"~op~"=q.c;"); return this; }
    /**
     ** p をベクトルとして, p*a, p/a を返します. r は数値です.
     **/
    pure Pos opBinary(string op, U)(U a) if ((op=="*"||op=="/") && isNumeric!U)
    { return mixin("pos(r"~op~"a, c"~op~"a)"); }
    /**
     ** p をベクトルとして, p*=a, p/=a を計算します. r は数値です.
     **/
    Pos opOpAssign(string op, U)(U a) if ((op=="*"||op=="/") && isNumeric!U)
    { mixin("r"~op~"=a; c"~op~"=a;"); return this; }
    /**
     ** p, q をベクトルとして, p と q の内積を返します.
     **/
    pure int opBinary(string op: "*", U)(U q) if (!isNumeric!U)
    { return r*q.r+c*q.c; }

    /**
     ** 周囲4方向の位置のうち, グリッド内にある位置を列挙して Range で返します.
     **/
    pure auto around4()
    {
      return [pos(r-1, c), pos(r, c+1), pos(r+1, c), pos(r, c-1)]
        .filter!(p => p.inGrid);
    }
    /**
     ** 周囲8方向の位置のうち, グリッド内にある位置を列挙して Range で返します.
     **/
    pure auto around8()
    {
      return [pos(r-1, c), pos(r-1, c+1), pos(r, c+1), pos(r+1, c+1),
              pos(r+1, c), pos(r+1, c-1), pos(r, c-1), pos(r-1, c-1)]
        .filter!(p => p.inGrid);
    }
  }

  /**
   ** h は行数, w は列数です.
   **/
  size_t h, w;
  /**
   ** グリッドの要素を保持する配列です.
   **/
  T[][] data;

  /**
   ** data を元にしたグリッドを返します.
   **/
  this(size_t h, size_t w) { this.h = h; this.w = w; data = new T[][](h, w); }
  /**
   ** data を元にしたグリッドを返します.
   **/
  this(T[][] data) { h = data.length; w = data[0].length; this.data = data; }
  /**
   ** コピーを返します.
   **/
  pure Grid!T dup() { return new Grid!T(data.map!"a.dup".array); }

  /**
   ** 位置 (r, c) を返します.
   **/
  pure Pos pos(int r, int c) { return new Pos(r, c); }

  /**
   ** 位置 (r, c) の要素を返します.
   **/
  pure T opIndex(size_t r, size_t c) { return data[r][c]; }
  /**
   ** 位置 p の要素を返します.
   **/
  pure T opIndex(U)(U p) { return data[p.r][p.c]; }
  /**
   ** 位置 (r, c) の要素を v に変更します.
   **/
  Grid!T opIndexAssign(T v, size_t r, size_t c) { data[r][c] = v; return this; }
  /**
   ** 位置 p の要素を v に変更します.
   **/
  Grid!T opIndexAssign(U)(T v, U p) { data[p.r][p.c] = v; return this; }
  /**
   ** 位置 (r, c) の値を演算子 op を値 v で適用したしたものに変更します.
   **/
  Grid!T opIndexOpAssign(string op)(T v, size_t r, size_t c)
  { mixin("data[r][c]"~op~"=v;"); return this; }
  /**
   ** 位置 p の値を演算子 op を値 v でを適用したしたものに変更します.
   **/
  Grid!T opIndexOpAssign(string op, U)(T v, U p)
  { mixin("data[p.r][p.c]"~op~"=v;"); return this; }
  /**
   ** 位置 (r, c) の値を 1 だけ加算/減算します.
   **/
  Grid!T opIndexUnary(string op)(size_t r, size_t c) if (op=="++"||op=="--")
  { mixin(op~"data[r][c];"); return this; }
  /**
   ** 位置 p の値を 1 だけ加算/減算します.
   **/
  Grid!T opIndexUnary(string op, U)(U p) if (op=="++"||op=="--")
  { mixin(op~"data[p.r][p.c];"); return this; }

  /**
   ** すべての位置を列挙して Range で返します.
   **/
  auto walk()
  { return WalkRange(this); }

  private struct WalkRange
  {
    Grid!T g;
    int r, c;
    this(Grid!T g) { this.g = g; r = 0; c = 0; }
    @property pure Pos front() { return g.pos(r, c); }
    void popFront() { if (++c >= g.w) { c = 0; ++r; } }
    pure bool empty() { return r >= g.h; }
  }
}
/**
 ** data を元にしたグリッドを返します.
 **/
Grid!T grid(T)(size_t h, size_t w) { return new Grid!T(h, w); }
/**
 ** data を元にしたグリッドを返します.
 **/
Grid!T grid(T)(T[][] data) { return new Grid!T(data); }

/**
 ** p1, p2 のマンハッタン距離を返します.
 **/
pure int distManhattan(T)(T p1, T p2) { return abs(p1.r-p2.r) + abs(p1.c-p2.c); }
// ::::::::::::::::::::

unittest
{
  auto a = new Grid!int([[1, 2], [3, 4]]);

  auto p1 = a.pos(2, 4);

  assert(p1.r == 2);
  assert(p1.c == 4);
  assert(a.pos(1, 1).p2i == 3);

  assert(a.pos(1, 0).inGrid);
  assert(!a.pos(0, 2).inGrid);

  auto p2 = a.pos(1, 3);

  assert(p1 + p2 == a.pos(3, 7));
  assert(p1 - p2 == a.pos(1, 1));
  assert(p1 * p2 == 14);
  assert(p1 * 2 == a.pos(4, 8));
  assert(p1 / 3 == a.pos(0, 1));

  p1 = a.pos(2, 4); p1 += p2;
  assert(p1 == a.pos(3, 7));
  p1 = a.pos(2, 4); p1 -= p2;
  assert(p1 == a.pos(1, 1));
  p1 = a.pos(2, 4); p1 *= 2;
  assert(p1 == a.pos(4, 8));
  p1 = a.pos(2, 4); p1 /= 2;
  assert(p1 == a.pos(1, 2));

  auto b = a.dup; b[0, 0] = 2;
  assert(a[0, 0] == 1);
  assert(b[0, 0] == 2);

  assert(a[1, 0] == 3);
  assert(a[a.pos(0, 1)] == 2);

  a[1, 0] += 2;
  assert(a[1, 0] == 5);
  a[a.pos(0, 1)] -= 3;
  assert(a[0, 1] == -1);
  ++a[1, 0];
  assert(a[1, 0] == 6);
  --a[a.pos(0, 1)];
  assert(a[0, 1] == -2);

  assert(equal(a.walk, [a.pos(0, 0), a.pos(0, 1), a.pos(1, 0), a.pos(1, 1)]));
  assert(equal(a.pos(0, 0).around4, [a.pos(0, 1), a.pos(1, 0)]));
  assert(equal(a.pos(1, 1).around8, [a.pos(0, 1), a.pos(1, 0), a.pos(0, 0)]));

  assert(distManhattan(p1, p2) == 1);
}
