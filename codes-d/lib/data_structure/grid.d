module lib.data_structure.grid;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.data_structure.grid
/**
 ** 縦 h, 横 w の領域を表します.
 **/
template Region(alias h, alias w)
{
  /**
   ** 位置を表します.
   **/
  struct Pos
  {
    /**
     ** 行, 列の値です.
     **/
    int r, c;
    /**
     ** 行 r, 列 c の位置を作成します.
     **/
    pure this(int r, int c) { this.r = r; this.c = c; }
    /**
     ** 位置が領域内かどうかを返します.
     **/
    pure bool inRegion() { return 0 <= r && r < h && 0 <= c && c < w; }
    /**
     ** 1次元で考えたときのインデックスを返します.
     **/
    pure int p2i() { return cast(int)w*r+c; }

    /**
     ** p, q をベクトルとして, p+q, p-q を返します.
     **/
    pure Pos opBinary(string op)(Pos q) if (op=="+"||op=="-")
    { return mixin("Pos(r"~op~"q.r, c"~op~"q.c)"); }
    /**
     ** p, q をベクトルとして, p+=q, p-=q を計算します.
     **/
    Pos opOpAssign(string op)(Pos q) if (op=="+"||op=="-")
    { mixin("r"~op~"=q.r; c"~op~"=q.c;"); return this; }
    /**
     ** p をベクトルとして, p*a, p/a を返します. r は数値です.
     **/
    pure Pos opBinary(string op, U)(U a) if (op=="*"||op=="/")
    { return mixin("Pos(r"~op~"a, c"~op~"a)"); }
    /**
     ** p をベクトルとして, p*=a, p/=a を計算します. r は数値です.
     **/
    Pos opOpAssign(string op, U)(U a) if (op=="*"||op=="/")
    { mixin("r"~op~"=a; c"~op~"=a;"); return this; }
    /**
     ** p, q をベクトルとして, p と q の内積を返します.
     **/
    pure int opBinary(string op: "*")(Pos q)
    { return r*q.r+c*q.c; }

    /**
     ** 周囲4方向の位置のうち, 領域内にある位置を列挙して Range で返します.
     **/
    pure auto around4()
    {
      return [Pos(r-1, c), Pos(r, c+1), Pos(r+1, c), Pos(r, c-1)]
        .filter!(p => p.inRegion);
    }
    /**
     ** 周囲8方向の位置のうち, 領域内にある位置を列挙して Range で返します.
     **/
    pure auto around8()
    {
      return [Pos(r-1, c), Pos(r-1, c+1), Pos(r, c+1), Pos(r+1, c+1),
              Pos(r+1, c), Pos(r+1, c-1), Pos(r, c-1), Pos(r-1, c-1)]
        .filter!(p => p.inRegion);
    }
  }

  /**
   ** すべての位置を列挙して Range で返します.
   **/
  auto allPos() { return AllPosRange(); }

  private struct AllPosRange
  {
    int r, c;
    @property pure Pos front() { return Pos(r, c); }
    void popFront() { if (++c >= w) { c = 0; ++r; } }
    pure bool empty() { return r >= h; }
  }

  /**
   ** グリッドを表します.
   **/
  struct Grid(T)
  {
    /**
     ** グリッドの要素を保持する配列です.
     **/
    T[][] data;
    /**
     ** data を元にしたグリッドを返します.
     **/
    pure this(T[][] data) { this.data = data; }
    /**
     ** コピーを返します.
     **/
    pure Grid!T dup() { return Grid!T(data.map!"a.dup".array); }

    /**
     ** 位置 (r, c) の要素を返します.
     **/
    pure T opIndex(size_t r, size_t c) { return data[r][c]; }
    /**
     ** 位置 p の要素を返します.
     **/
    pure T opIndex(Pos p) { return data[p.r][p.c]; }
    /**
     ** 位置 (r, c) の要素を v に変更します.
     **/
    Grid!T opIndexAssign(T v, size_t r, size_t c) { data[r][c] = v; return this; }
    /**
     ** 位置 p の要素を v に変更します.
     **/
    Grid!T opIndexAssign(T v, Pos p) { data[p.r][p.c] = v; return this; }
    /**
     ** 位置 (r, c) の値を演算子 op を値 v で適用したしたものに変更します.
     **/
    Grid!T opIndexOpAssign(string op)(T v, size_t r, size_t c)
    { mixin("data[r][c]"~op~"=v;"); return this; }
    /**
     ** 位置 p の値を演算子 op を値 v でを適用したしたものに変更します.
     **/
    Grid!T opIndexOpAssign(string op)(T v, Pos p)
    { mixin("data[p.r][p.c]"~op~"=v;"); return this; }
    /**
     ** 位置 (r, c) の値を 1 だけ加算/減算します.
     **/
    Grid!T opIndexUnary(string op)(size_t r, size_t c) if (op=="++"||op=="--")
      { mixin(op~"data[r][c];"); return this; }
    /**
     ** 位置 p の値を 1 だけ加算/減算します.
     **/
    Grid!T opIndexUnary(string op)(Pos p) if (op=="++"||op=="--")
      { mixin(op~"data[p.r][p.c];"); return this; }
  }
  /**
   ** 型 T のグリッドを返します.
   **/
  pure Grid!T grid(T)(T[][] data = new T[][](h, w)) { return Grid!T(data); }
}
// ::::::::::::::::::::

unittest
{
  auto m = [[1, 2], [3, 4]];
  alias rg = Region!(2, 2), Pos = rg.Pos;
  auto a = rg.grid([[1, 2], [3, 4]]);

  auto p1 = Pos(2, 4);

  assert(p1.r == 2);
  assert(p1.c == 4);
  assert(Pos(1, 1).p2i == 3);

  assert(Pos(1, 0).inRegion);
  assert(!Pos(0, 2).inRegion);

  auto p2 = Pos(1, 3);

  assert(p1 + p2 == Pos(3, 7));
  assert(p1 - p2 == Pos(1, 1));
  assert(p1 * p2 == 14);
  assert(p1 * 2 == Pos(4, 8));
  assert(p1 / 3 == Pos(0, 1));

  p1 = Pos(2, 4); p1 += p2;
  assert(p1 == Pos(3, 7));
  p1 = Pos(2, 4); p1 -= p2;
  assert(p1 == Pos(1, 1));
  p1 = Pos(2, 4); p1 *= 2;
  assert(p1 == Pos(4, 8));
  p1 = Pos(2, 4); p1 /= 2;
  assert(p1 == Pos(1, 2));

  auto b = a.dup; b[0, 0] = 2;
  assert(a[0, 0] == 1);
  assert(b[0, 0] == 2);

  assert(a[1, 0] == 3);
  assert(a[Pos(0, 1)] == 2);

  a[1, 0] += 2;
  assert(a[1, 0] == 5);
  a[Pos(0, 1)] -= 3;
  assert(a[0, 1] == -1);
  ++a[1, 0];
  assert(a[1, 0] == 6);
  --a[Pos(0, 1)];
  assert(a[0, 1] == -2);

  alias rg2 = Region!(1, 2), rg3 = Region!(2, 1);
  auto c = rg2.grid([[1, 2]]), d = rg3.grid!int();
  assert(Pos(1, 1).inRegion);
  assert(!rg2.Pos(1, 0).inRegion);
  assert(!rg3.Pos(0, 1).inRegion);

  assert(equal(rg.allPos, [Pos(0, 0), Pos(0, 1), Pos(1, 0), Pos(1, 1)]));
  assert(equal(Pos(0, 0).around4, [Pos(0, 1), Pos(1, 0)]));
  assert(equal(Pos(1, 1).around8, [Pos(0, 1), Pos(1, 0), Pos(0, 0)]));
}
