struct UnionFind
{
  import std.algorithm, std.range;

  int[] p;
  const size_t n;
  const int s;
  size_t cf;
  size_t[] cn;

  this(size_t n)
  {
    this.n = n;
    s = cast(int)n;
    p = new int[](n);
    p[] = s;
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

  bool isSame(int i, int j) { return subst(i) == subst(j); }
  @property countForests() { return cf; }
  auto countNodes(int i) { return cn[subst(i)]; }

  auto groups()
  {
    auto g = new int[][](n);
    foreach (i; 0..cast(int)n) g[subst(i)] ~= i;
    return g.filter!(l => !l.empty);
  }

private:

  int subst(int i) { return p[i] == s ? i : (p[i] = subst(p[i])); }
}

/*

  UnionFind

    Union-Find を表す構造体です.

  UnionFind(n)

    頂点数が n の UnionFind 構造体を作成します.

  uf.unite(u, v)

    頂点 u と頂点 v を連結します.

  uf.isSame(u, v)

    頂点 u と頂点 v が同じ森に属するを持つかどうかを返します.

  uf.countForests

    森の数を返します.

  uf.countNodes(u)

    頂点 u が所属する森に所属する頂点数を返します.

 */

unittest
{
  import std.range;

  auto uf = UnionFind(6);

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

  auto g = uf.groups.array;
  assert(g[0] == [0, 1, 2]);
  assert(g[1] == [3, 5]);
  assert(g[2] == [4]);
}
