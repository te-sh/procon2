module lib.data_structure.grid;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.data_structure.grid
import lib.math.point;

/**
 ** グリッドを表します.
 **/
struct Grid(T)
{
  alias G = Grid!T, P = Point2!int, Point = P;
  /**
   ** c は列数, r は行数です.
   **/
  size_t c, r;
  /**
   ** グリッドの要素を保持する配列です.
   **/
  T[][] data;

  /**
   ** c 列 n 行のグリッドを返します.
   **/
  this(size_t c, size_t r) { this.c = c; this.r = r; data = new T[][](r, c); }
  /**
   ** data を元にしたグリッドを返します.
   **/
  this(T[][] data) { c = data[0].length; r = data.length; this.data = data; }

  /**
   ** 1次元インデックス i を位置にしたものを返します.
   **/
  pure P i2p(size_t i) { return P(cast(int)(i%c), cast(int)(i/c)); }
  /**
   ** 位置 p を1次元インデックスにしたものを返します.
   **/
  pure size_t p2i(P p) { return p.x*c + p.y; }

  /**
   ** 位置 (x, y) の要素を返します.
   **/
  pure T opIndex(size_t x, size_t y) { return data[y][x]; }
  /**
   ** 位置 p の要素を返します.
   **/
  pure T opIndex(P p) { return data[p.y][p.x]; }
  /**
   ** 位置 (x, y) の要素を v に変更します.
   **/
  G opIndexAssign(T v, size_t x, size_t y) { data[y][x] = v; return this; }
  /**
   ** 位置 p の要素を v に変更します.
   **/
  G opIndexAssign(T v, P p) { data[p.y][p.x] = v; return this; }
  /**
   ** 位置 (x, y) の値を演算子 op を値 v で適用したしたものに変更します.
   **/
  G opIndexOpAssign(string op)(T v, size_t x, size_t y)
  { mixin("data[y][x]"~op~"=v;"); return this; }
  /**
   ** 位置 p の値を演算子 op を値 v でを適用したしたものに変更します.
   **/
  G opIndexOpAssign(string op)(T v, P p)
  { mixin("data[p.y][p.x]"~op~"=v;"); return this; }
  /**
   ** 位置 (x, y) の値を 1 だけ加算/減算します.
   **/
  G opIndexUnary(string op)(size_t x, size_t y) if (op=="++"||op=="--")
  { mixin(op~"data[y][x];"); return this; }
  /**
   ** 位置 p の値を 1 だけ加算/減算します.
   **/
  G opIndexUnary(string op)(P p) if (op=="++"||op=="--")
  { mixin(op~"data[p.y][p.x];"); return this; }

  /**
   ** 位置 (x, y) がグリッド内かどうかを返します.
   **/
  pure bool valid(size_t x, size_t y) { return 0 <= x && x < c && 0 <= y && y < r; }
  /**
   ** 位置 p がグリッド内かどうかを返します.
   **/
  pure bool valid(P p) { return valid(p.x, p.y); }
  /**
   ** 周囲4方向を表す配列です.
   **/
  auto d4 = [P(-1, 0), P(0, -1), P(1, 0), P(0, 1)];
  /**
   ** p の周囲4方向の位置のうち, グリッド内にある位置を列挙して Range で返します.
   **/
  pure auto around4(P p) { return d4.map!(d => d+p).filter!(np => valid(np)); }
  /**
   ** 周囲8方向を表す配列です.
   **/
  auto d8 = [P(-1, 0), P(-1, -1), P(0, -1), P(1, -1), P(1, 0), P(1, 1), P(0, 1), P(-1, 1)];
  /**
   ** p の周囲8方向の位置のうち, グリッド内にある位置を列挙して Range で返します.
   **/
  pure auto around8(P p) { return d8.map!(d => d+p).filter!(np => valid(np)); }
}
/**
 ** data を元にしたグリッドを返します.
 **/
Grid!T grid(T)(T[][] data) { return Grid!T(data); }
// ::::::::::::::::::::

unittest
{
  auto a = Grid!int([[1, 2], [3, 4]]);
  alias P = a.P;

  assert(a[1, 0] == 2);
  assert(a[P(0, 1)] == 3);

  assert(a.i2p(2) == P(0, 1));
  assert(a.p2i(P(1, 1)) == 3);

  a[1, 0] = 5;
  assert(a[1, 0] == 5);
  a[P(0, 1)] = 6;
  assert(a[0, 1] == 6);

  a[1, 0] += 2;
  assert(a[1, 0] == 7);
  a[P(0, 1)] -= 3;
  assert(a[0, 1] == 3);
  ++a[1, 0];
  assert(a[1, 0] == 8);
  --a[P(0, 1)];
  assert(a[0, 1] == 2);

  assert(a.valid(1, 0));
  assert(!a.valid(2, 0));
  assert(a.valid(P(0, 1)));
  assert(!a.valid(P(0, 2)));

  assert(equal(a.around4(P(0, 0)), [P(1, 0), P(0, 1)]));
  assert(equal(a.around8(P(1, 1)), [P(0, 1), P(0, 0), P(1, 0)]));
}
