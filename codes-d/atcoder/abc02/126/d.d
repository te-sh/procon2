// URL: https://atcoder.jp/contests/abc126/tasks/abc126_d

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
  int n; readV(n);

  auto g = GraphW!int(n); alias Edge = g.Edge;
  foreach (_; 0..n-1) {
    int u, v, w; readV(u, v, w); --u; --v;
    g.addEdgeB(u, v, w);
  }

  auto d = new long[](n);
  auto bfs = bfsw(g);
  bfs.findEdge ~= (Edge e) { d[e.dst] = d[e.src] + e.wt; };
  bfs.run(0);

  foreach (di; d)
    writeln(di%2 ? 1 : 0);
}

struct GraphW(W = int, W i = 10^^9)
{
  alias Node = int, Wt = W, inf = i;
  struct Edge { Node src, dst; Wt wt; alias cap = wt; }
  Node n;
  Edge[][] g;
  alias g this;
  this(Node n) { this.n = n; g = new Edge[][](n); }
  void addEdge(Node u, Node v, Wt w) { g[u] ~= Edge(u, v, w); }
  void addEdgeB(Node u, Node v, Wt w) { g[u] ~= Edge(u, v, w); g[v] ~= Edge(v, u, w); }
}

struct BFSW(Graph)
{
  import std.algorithm, std.container;
  Graph g;
  alias Node = g.Node, Edge = g.Edge;
  void delegate(Node)[] findNode;
  void delegate(Edge)[] findEdge;

  this(ref Graph g) { this.g = g; }
  auto run(Node s)
  {
    auto visited = new bool[](g.n);
    auto q = DList!(Node)(s);
    visited[s] = true;
    findNode.each!(f => f(s));

    while (!q.empty) {
      auto u = q.front; q.removeFront();
      foreach (e; g[u])
        if (!visited[e.dst]) {
          visited[e.dst] = true;
          findNode.each!(f => f(e.dst));
          findEdge.each!(f => f(e));
          q.insertBack(e.dst);
        }
    }
  }
}
auto bfsw(G)(ref G g) { return BFSW!G(g); }
