import graph;

struct FloydWarshal(Graph)
{
  import std.algorithm, std.array;
  Graph g;
  alias g this;
  alias Wt = g.Wt;
  Wt[][] dist;

  this(Graph g)
  {
    this.g = g;
    dist = g.g.map!(i => i.dup).array;

    foreach (k; 0..n)
      foreach (i; 0..n)
        foreach (j; 0..n)
          if (dist[i][j] > dist[i][k] + dist[k][j])
            dist[i][j] = dist[i][k] + dist[k][j];
  }
}
FloydWarshal!Graph floydWarshal(Graph)(Graph g) { return FloydWarshal!Graph(g); }


/*

  struct FloydWarshal(Graph)

    Floyd-Warshal 法により最短距離を計算します. Graph は隣接行列によるグラフです.

    FloydWarshal!Graph(Graph g, Node s)

      各頂点間の最短距離を dist にセットします.

    Wt[][] dist;

      各頂点間の最短距離を保持する配列です.

  FloydWarshal!Graph floydWarshal(Graph)(Graph g)

    各頂点間の最短距離を dist にセットします.

*/

unittest
{
  auto g = GraphM!int.init(5);

  g[0][1] = 10;
  g[0][3] = 100;
  g[1][3] = 1000;
  g[2][1] = 1;
  g[2][3] = 10000;
  g[3][0] = 5;

  auto dist = g.floydWarshal.dist;
  assert(dist[0][1] == 10);
  assert(dist[2][3] == 1001);
  assert(dist[3][1] == 15);
  assert(dist[4][2] == g.inf);
}
