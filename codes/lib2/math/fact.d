struct Fact(T, bool noInv = false)
{
  size_t n;
  T[] table, invTable;

  this(size_t n)
  {
    this.n = n;

    table = new T[](n+1); table[0] = 1;
    foreach (i; 1..cast(int)n+1) table[i] = table[i-1]*i;

    static if (!noInv) {
      invTable = new T[](n+1); invTable[n] = T(1)/table[n];
      foreach_reverse (i; 1..cast(int)n+1) invTable[i-1] = invTable[i]*i;
    }
  }

  auto combi(size_t a, size_t b)
  in { assert(!noInv && n >= a && a >= b); }
  body {
    return table[a]*invTable[b]*invTable[a-b];
  }
}

/*

  Fact!T

    階乗および階乗の逆数のテーブルを作成する構造体です.
    T は ModInt を使うことがほとんどでしょう.
    組み合わせ数 nCr を求めるために使われることが多いです.

  Fact!T(n)

    n 以下の階乗および階乗の逆数を計算して table, invTable にセットします.

  fact.combi(a, b)

    組み合わせ数 aCb を返します.
    n >= a >= b である必要があります.

 */

unittest {
  import mod_int;

  auto fact = Fact!(ModInt!7)(5);
  assert(fact.table == [1, 1, 2, 6, 3, 1]);
  assert(fact.invTable == [1, 1, 4, 6, 5, 1]);

  assert(fact.combi(5, 2) == 3);
}
