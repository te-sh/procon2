module lib.string.lcp_array;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.string.lcp_array
import lib.string.suffix_array;

/**
 ** LCP Array (最長共通接尾辞配列) を計算します.
 **/
struct LcpArray
{
  /**
   ** 計算の元となった文字列の長さです.
   **/
  size_t n;
  /**
   ** i 番目の LCP を保持する配列です.
   **/
  size_t[] x;
  alias x this;

  pure nothrow @safe
  {
    /**
     ** Suffix Array sa を元に LCP を計算した結果を保持する構造体を返します.
     **/
    this(SuffixArray sa)
    {
      n = sa.n;
      x = new size_t[](n);
      rank = new size_t[](n);
      foreach (i; 0..n) rank[sa.x[i]] = i;

      auto h = size_t(0);
      foreach (i; 0..n)
        if (rank[i]+1 < n) {
          auto j = sa.x[rank[i]+1];
          while (max(i, j)+h < n && sa.s[i+h] == sa.s[j+h]) ++h;
          x[rank[i]+1] = h;
          if (h > 0) --h;
        }
    }
  }

  private
  {
    size_t[] rank;
  }
}
// ::::::::::::::::::::

unittest
{
  auto s = "abracadabra";
  auto sa = SuffixArray(s);
  auto lcp = LcpArray(sa);

  assert(lcp[0] == 0);
  assert(lcp[1] == 1);
  assert(lcp[2] == 4);
  assert(lcp[3] == 1);
  assert(lcp[4] == 1);
  assert(lcp[5] == 0);
  assert(lcp[6] == 3);
  assert(lcp[7] == 0);
  assert(lcp[8] == 0);
  assert(lcp[9] == 0);
  assert(lcp[10] == 2);
}
