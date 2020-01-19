class UnionFind
{
  import std.algorithm, std.range;

  int[] p;
  int n, s;
  size_t cf;
  size_t[] cn;

  this(int n)
  {
    this.n = this.s = n;
    p = new int[](n); p[] = s;
    cf = n;
    cn = new size_t[](n); cn[] = 1;
  }

  bool unite(int i, int j)
  {
    auto pi = subst(i), pj = subst(j);
    if (pi != pj) {
      p[pj] = pi;
      --cf;
      cn[pi] += cn[pj];
      return true;
    } else {
      return false;
    }
  }

  bool isSame(int u, int v) { return subst(u) == subst(v); }
  size_t countForests() { return cf; }
  size_t countNodes(int u) { return cn[subst(u)]; }

  auto groups()
  {
    auto g = new int[][](n);
    foreach (i; 0..n) g[subst(i)] ~= i;
    return g.filter!(l => !l.empty);
  }

private:

  int subst(int i) { return p[i] == s ? i : (p[i] = subst(p[i])); }
}

/*

  UnionFind

    Union-Find を管理します.

    new UnionFind(int n)

      頂点数が n の Union-Find を作成します.

    bool unite(int i, int j)

      頂点 u と頂点 v を連結します.
      別の森に含まれる頂点が連結されたかどうかを返します.

    bool isSame(int u, int v)

      頂点 u と頂点 v が同じ森に含まれるかどうかを返します.

    size_t countForests()

      森の数を返します.

    size_t countNodes(int u)

      頂点 u が所属する森に所属する頂点数を返します.

    auto groups()

      森ごとに含まれる頂点の配列の Range を返します.

*/

unittest
{
  import std.algorithm, std.range;

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
