struct UnionFind(T)
{
  import std.algorithm, std.range;

  T[] p; // parent
  const T s; // sentinel
  const T n;
  T countForests; // number of forests
  T[] countNodes; // number of nodes in forests

  this(T n)
  {
    this.n = n;
    s = n;
    p = new T[](n);
    p[] = s;
    countForests = n;
    countNodes = new T[](n);
    countNodes[] = 1;
  }

  T opIndex(T i)
  {
    if (p[i] == s) {
      return i;
    } else {
      p[i] = this[p[i]];
      return p[i];
    }
  }

  bool unite(T i, T j)
  {
    auto pi = this[i], pj = this[j];
    if (pi != pj) {
      p[pj] = pi;
      --countForests;
      countNodes[pi] += countNodes[pj];
      return true;
    } else {
      return false;
    }
  }

  auto countNodesOf(T i) { return countNodes[this[i]]; }
  bool isSame(T i, T j) { return this[i] == this[j]; }

  auto groups()
  {
    auto g = new T[][](n);
    foreach (i; 0..n) g[this[i]] ~= i;
    return g.filter!(l => !l.empty);
  }
}

unittest
{
  import std.range;

  auto uf = UnionFind!size_t(6);

  assert(uf.countForests == 6);
  foreach (i; 0..6)
    assert(uf[i] == i);

  uf.unite(0, 1);
  assert(uf.countForests == 5);
  assert(uf[0] == uf[1]);
  assert(uf.countNodesOf(1) == 2);

  uf.unite(0, 2);
  assert(uf.countNodesOf(1) == 3);
  foreach (i; 0..2)
    foreach (j; i+1..2)
      assert(uf.isSame(i, j));

  uf.unite(3, 5);
  assert(uf.countForests == 3);
  assert(uf[3] == uf[5]);

  auto g = uf.groups.array;
  assert(g[0] == [0, 1, 2]);
  assert(g[1] == [3, 5]);
  assert(g[2] == [4]);
}
