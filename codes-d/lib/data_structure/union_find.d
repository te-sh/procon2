module lib.data_structure.union_find;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.data_structure.union_find
/**
 ** Union-Find を用いてグラフの連結を管理します.
 **/
class UnionFind
{
  /**
   ** グラフの頂点数です.
   **/
  int n;

  /**
   ** n 頂点のグラフの連結を管理する構造体を返します.
   **/
  this(int n)
  {
    this.n = this.s = n;
    p = new int[](n); p[] = s;
    cf = n;
    cn = new size_t[](n); cn[] = 1;
  }

  /**
   ** 頂点 u と頂点 v を連結します.
   **/
  bool unite(int u, int v)
  {
    auto pu = subst(u), pv = subst(v);
    if (pu != pv) {
      p[pv] = pu;
      --cf;
      cn[pu] += cn[pv];
      return true;
    } else {
      return false;
    }
  }

  /**
   ** 頂点 u と頂点 v が同じ連結部分にあるかどうかを返します.
   **/
  bool isSame(int u, int v) { return subst(u) == subst(v); }
  /**
   ** グラフの連結部分の数を返します.
   **/
  size_t countForests() { return cf; }
  /**
   ** 頂点 u を含む連結部分に含まれる頂点の数を返します.
   **/
  size_t countNodes(int u) { return cn[subst(u)]; }

  /**
   ** 連結部分ごとの頂点を配列にしたものを列挙して Range で返します.
   **/
  auto groups()
  {
    auto g = new int[][](n);
    foreach (i; 0..n) g[subst(i)] ~= i;
    return g.filter!(l => !l.empty);
  }

  private
  {
    int[] p;
    int s;
    size_t cf;
    size_t[] cn;

    int subst(int i) { return p[i] == s ? i : (p[i] = subst(p[i])); }
  }
}
UnionFind unionFind(int n) { return new UnionFind(n); }
// ::::::::::::::::::::

unittest
{
  auto uf = new UnionFind(6);

  assert(uf.countForests == 6);

  uf.unite(0, 1);
  assert(uf.countForests == 5);
  assert(uf.countNodes(1) == 2);

  uf.unite(0, 2);
  assert(uf.countNodes(1) == 3);
  foreach (i; 0..2)
    foreach (j; i+1..2)
      assert(uf.isSame(i, j));

  uf.unite(3, 5);
  assert(uf.countForests == 3);

  assert(equal(uf.groups, [[0, 1, 2], [3, 5], [4]]));
}
