module lib.math.fact;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.math.fact
/**
 ** 階乗および逆元を計算します.
 ** T は ModInt を使うことがほとんどでしょう.
 ** inv が false なら逆元は計算しません.
 **/
struct Fact(T, bool inv = true)
{
  /**
   ** 階乗テーブルの要素数です.
   **/
  int n;
  /**
   ** 階乗を保持する配列です.
   **/
  T[] table;
  alias table this;
  /**
   ** 階乗の逆数を保持する配列です.
   ** inv が false なら定義されません.
   **/
  static if (inv) T[] invTable;

  /**
   ** n 以下の階乗および逆元の計算結果を保持する構造体を返します.
   **/
  this(int n)
  {
    this.n = n;

    table = new T[](n+1); table[0] = 1;
    foreach (i; 1..n+1) table[i] = table[i-1]*i;

    static if (inv) {
      invTable = new T[](n+1); invTable[n] = T(1)/table[n];
      foreach_reverse (i; 1..n+1) invTable[i-1] = invTable[i]*i;
    }
  }

  static if (inv) {
    /**
     ** 順列数 aPb を返します.
     ** inv が false なら定義されません.
     ** n >= a >= b である必要があります.
     **/
    pure T perm(size_t a, size_t b) in { assert(n >= a && a >= b); } do
    { return table[a]*invTable[a-b]; }

    /**
     ** 組み合わせ数 aCb を返します.
     ** inv が false なら定義されません.
     ** n >= a >= b である必要があります.
     **/
    pure T combi(size_t a, size_t b) in { assert(n >= a && a >= b); } do
    { return table[a]*invTable[b]*invTable[a-b]; }

    /**
     ** 重複組み合わせ数 aHb を返します.
     ** inv が false なら定義されません.
     ** n >= a + b - 1 である必要があります.
     **/
    pure T homo(size_t a, size_t b) in { assert(n >= a+b-1); } do
    { return combi(a+b-1, b); }
  }
}
// ::::::::::::::::::::

unittest
{
  import lib.math.mod_int;

  auto fact = Fact!(ModInt!7)(5);
  assert(equal(fact.table, [1, 1, 2, 6, 3, 1]));
  assert(equal(fact.invTable, [1, 1, 4, 6, 5, 1]));

  assert(fact.perm(5, 2) == 6);
  assert(fact.combi(5, 2) == 3);
  assert(fact.homo(3, 2) == 6);
}
