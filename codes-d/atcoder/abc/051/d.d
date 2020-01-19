// URL: https://atcoder.jp/contests/abc051/tasks/abc051_d

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);

  auto g = GraphM!int(n).init;
  foreach (_; 0..m) {
    int a, b, c; readV(a, b, c); --a; --b;
    g[a][b] = g[b][a] = c;
  }

  auto d = g.floydWarshal, ans = 0;

  foreach (i; 0..n)
    foreach (j; i+1..n)
      if (g[i][j] < g.inf && g[i][j] > d[i][j]) ++ans;

  writeln(ans);
}

struct GraphM(W = int, W i = 10^^9)
{
  alias Wt = W, inf = i;
  int n;
  Wt[][] g;
  alias g this;
  this(int n) { this.n = n; g = new Wt[][](n, n); }
  ref auto init() { foreach (i; 0..n) { g[i][] = inf; g[i][i] = 0; } return this; }
}

template FloydWarshal(Graph)
{
  import std.algorithm, std.array, std.traits;
  alias Wt = TemplateArgsOf!Graph[0];

  Wt[][] floydWarshal(ref Graph g)
  {
    Wt[][] dist;
    int[][] inter;
    floydWarshal(g, dist, inter);
    return dist;
  }

  void floydWarshal(ref Graph g, out Wt[][] dist, out int[][] inter)
  {
    auto n = g.n, sent = n;
    dist = g.g.map!(i => i.dup).array;

    inter = new int[][](n, n);
    foreach (i; 0..n) inter[i][] = sent;

    foreach (k; 0..n)
      foreach (i; 0..n)
        foreach (j; 0..n)
          if (dist[i][j] > dist[i][k] + dist[k][j]) {
            dist[i][j] = dist[i][k] + dist[k][j];
            inter[i][j] = k;
          }
  }
}
auto floydWarshal(G)(G g) { return FloydWarshal!(typeof(g)).floydWarshal(g); }
