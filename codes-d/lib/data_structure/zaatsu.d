module lib.data_structure.zaatsu;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.data_structure.zaatsu
/**
 ** 座標圧縮/展開を行います.
 **/
struct Zaatsu(T)
{
  /**
   ** 座標圧縮した結果の数値の種類数です.
   **/
  const size_t n;

  /**
   ** v を元にした座標圧縮の元データを保持するオブジェクトを返します.
   **/
  pure nothrow @safe
  {
    this(U...)(U v)
    {
      T[] d;
      foreach (w; v) d ~= w.array;
      auto u = d.sort.uniq;
      n = u.walkLength;
      c2 = new T[](n);

      foreach (i, ui; u.enumerate(0)) {
        c1[ui] = i;
        c2[i] = ui;
      }
    }

    /**
     ** 1つの値 v を座標圧縮した値を返します.
     **/
    int comp(T v) { return c1[v]; }
    /**
     ** Range v の各値を座標圧縮した Range を返します.
     **/
    auto comp(R)(R v) if (isInputRange!R) { return v.map!(w => c1[w]); }

    /**
     ** 座標圧縮された1つの値 v を元に戻した値を返します.
     **/
    T uncomp(int v) { return c2[v]; }
    /**
     ** 座標圧縮された Range v の各値を元に戻した Range を返します.
     **/
    auto uncomp(R)(R v) if (isInputRange!R) { return v.map!(w => c2[w]); }
  }

  private
  {
    int[T] c1;
    T[] c2;
  }
}
// ::::::::::::::::::::

unittest
{
  auto a = [1, 8, 2, 6];

  auto za1 = Zaatsu!int(a);
  assert(za1.n == 4);
  assert(za1.comp(1) == 0);
  assert(equal(za1.comp(a), [0, 3, 1, 2]));
  assert(za1.uncomp(2) == 6);
  assert(equal(za1.uncomp([3, 1]), [8, 2]));

  auto b = [4, 1];
  auto za2 = Zaatsu!int(a, b);
  assert(za2.n == 5);
  assert(za2.comp(2) == 1);
  assert(equal(za2.comp(a), [0, 4, 1, 3]));
  assert(za2.uncomp(3) == 6);
  assert(equal(za2.uncomp([2, 0]), [4, 1]));
}
