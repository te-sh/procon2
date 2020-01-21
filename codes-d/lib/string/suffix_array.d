module lib.string.suffix_array;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.string.suffix_array
/**
 ** Suffix Array (接尾辞配列) を計算します.
 **/
struct SuffixArray
{
  /**
   ** 計算の元となった文字列です.
   **/
  string s;
  /**
   ** 計算の元となった文字列の長さです.
   **/
  size_t n;
  /**
   ** i 番目の Suffix が何文字目から始まるかを保持する配列です.
   **/
  size_t[] x;

  /**
   ** 文字列 s を元に Suffix Array を計算した結果を保持する構造体を返します.
   **/
  this(string s)
  {
    this.s = s;
    n = s.length;
    x = new size_t[](n);
    auto r = new size_t[](n), t = new size_t[](n);

    foreach (i; 0..n) r[x[i] = i] = s[i];
    for (size_t h = 1; t[n-1] != n-1; h <<= 1) {
      auto cmp(size_t i, size_t j)
      {
        if (r[i] != r[j]) return r[i] < r[j];
        return i+h < n && j+h < n ? r[i+h] < r[j+h] : i > j;
      }
      x.sort!((a, b) => cmp(a, b));
      foreach (i; 0..n-1) t[i+1] = t[i] + cmp(x[i], x[i+1]);
      foreach (i; 0..n) r[x[i]] = t[i];
    }
  }

  /**
   ** n 番目の Suffix を返します.
   **/
  string opIndex(size_t i) { return s[x[i]..$]; }
}
// ::::::::::::::::::::

unittest
{
  auto s = "aeadacab";
  auto sa = SuffixArray(s);

  assert(sa[0] == "ab");
  assert(sa[1] == "acab");
  assert(sa[2] == "adacab");
  assert(sa[3] == "aeadacab");
  assert(sa[4] == "b");
  assert(sa[5] == "cab");
  assert(sa[6] == "dacab");
  assert(sa[7] == "eadacab");
}
