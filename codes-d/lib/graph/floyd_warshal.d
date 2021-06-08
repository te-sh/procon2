module lib.graph.floyd_warshal;
import std;

// :::::::::::::::::::: lib.graph.floyd_warshal
import lib.graph.graph;

/**
 ** Floyd-Warshal 法で任意の2頂点間の最短距離を計算します.
 **/
struct FloydWarshal(Graph)
{
  alias Wt = Graph.Wt;
  /**
   ** 計算に使用したグラフです.
   **/
  Graph g;
  alias g this;
  /**
   ** 任意の2頂点間の最短距離を持つ配列です.
   **/
  Wt[][] dist;

  pure nothrow @safe
  {
    /**
     ** グラフ g の任意の2頂点間の最短距離を Floyd-Warshal 法で
     ** 計算した結果を保持する構造体を返します.
     **/
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
}

pure nothrow @safe
{
  /**
   ** グラフ g の任意の2頂点間の最短距離を Floyd-Warshal 法で
   ** 計算した結果を保持する構造体を返します.
   **/
  auto floydWarshal(Graph)(Graph g)
  {
    return FloydWarshal!Graph(g);
  }
}
// ::::::::::::::::::::

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
