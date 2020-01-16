struct Fact(T, bool inv = true)
{
  int n;
  T[] table, invTable;
  alias table this;

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

  pure T perm(size_t a, size_t b) in { assert(inv && n >= a && a >= b); } do
  {
    return table[a]*invTable[a-b];
  }

  pure T combi(size_t a, size_t b) in { assert(inv && n >= a && a >= b); } do
  {
    return table[a]*invTable[b]*invTable[a-b];
  }

  pure T homo(size_t a, size_t b) in { assert(inv && n >= a+b-1); } do
  {
    return combi(a+b-1, b);
  }
}

/*

  struct Fact(T, bool inv = true)

    階乗および階乗の逆数のテーブルを保持します.
    T は ModInt を使うことがほとんどでしょう.
    inv が false ならば逆数のテーブルを計算しません.

    Fact!T(n)

      n 以下の階乗および階乗の逆数を計算して table, invTable にセットします.

    pure T perm(size_t a, size_t b)

      順列数 aPb を返します.
      n >= a >= b である必要があります.

    pure T combi(size_t a, size_t b)

      組み合わせ数 aCb を返します.
      n >= a >= b である必要があります.

    pure T homo(size_t a, size_t b)

      重複組み合わせ数 aHb を返します.
      n >= a + b - 1 である必要があります.

*/

unittest
{
  import mod_int;

  auto fact = Fact!(ModInt!7)(5);
  assert(fact.table == [1, 1, 2, 6, 3, 1]);
  assert(fact.invTable == [1, 1, 4, 6, 5, 1]);

  assert(fact.perm(5, 2) == 6);
  assert(fact.combi(5, 2) == 3);
  assert(fact.homo(3, 2) == 6);
}
