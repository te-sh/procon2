// URL: https://beta.atcoder.jp/contests/arc063/tasks/arc063_c

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

  auto g = Graph!int(n);
  foreach (_; 0..n-1) {
    int a, b; readV(a, b); --a; --b;
    g.addEdgeB(a, b);
  }

  auto t = g.makeTree.rootify(0);

  auto mm = new MM[](n);
  foreach (i; 0..n) mm[i] = MM.infty;

  int k; readV(k);
  foreach (_; 0..k) {
    int v, p; readV(v, p); --v;
    mm[v] = MM(p, p);
  }

  auto st = SList!int(), qu = DList!int(0);
  while (!qu.empty) {
    auto u = qu.front; qu.removeFront;
    st.insertFront(u);
    foreach (v; t.children(u)) qu.insertBack(v);
  }

  while (!st.empty) {
    auto u = st.front; st.removeFront;
    if (u != t.root) {
      auto p = t.parent[u];
      mm[p] = mm[p] & mm[u].expand;
    }
  }

  if (mm[0].isInvalid) {
    writeln("No");
    return;
  }

  auto r = new int[](n);
  r[0] = mm[0].isInfty ? 0 : mm[0].mi;
  qu.insertBack(0);
  while (!qu.empty) {
    auto u = qu.front; qu.removeFront;
    if (u != t.root) {
      auto p = t.parent[u];
      r[u] = mm[u].choose(r[p]-1, r[p]+1);
    }
    foreach (v; t.children(u)) qu.insertBack(v);
  }

  writeln("Yes");
  foreach (i; 0..n) writeln(r[i]);
}

struct MM
{
  static inf = 10^^9, inv = 10^^9+1;

  int mi, ma;

  this(int mi, int ma)
  {
    this.mi = mi;
    this.ma = ma;
  }

  static infty() { return MM(-inf, inf); }
  static invalid() { return MM(-inv, inv); }
  auto isInfty() { return this == MM.infty; }
  auto isInvalid() { return this == MM.invalid; }

  auto expand() { return isInfty ? this : MM(mi-1, ma+1); }
  auto opBinary(string op: "&")(MM a)
  {
    if (isInvalid || a.isInvalid) return MM.invalid;
    if (isInfty) return a;
    if (a.isInfty) return this;
    if (mi%2 != a.mi%2) return MM.invalid;
    auto mi2 = max(mi, a.mi), ma2 = min(ma, a.ma);
    return mi2 > ma2 ? MM.invalid : MM(mi2, ma2);
  }

  auto choose(int x, int y)
  {
    return x >= mi && x <= ma ? x : y;
  }
}

struct Graph(N = int)
{
  alias Node = N;
  Node n;
  Node[][] g;
  alias g this;
  this(Node n) { this.n = n; g = new Node[][](n); }
  void addEdge(Node u, Node v) { g[u] ~= v; }
  void addEdgeB(Node u, Node v) { g[u] ~= v; g[v] ~= u; }
}

struct Tree(Graph)
{
  import std.algorithm, std.container;
  alias Node = Graph.Node;
  Graph g;
  alias g this;
  Node root;
  Node[] parent;
  int[] size, depth;

  this(ref Graph g) { this.g = g; this.n = g.n; }

  ref auto rootify(Node r)
  {
    this.root = r;

    parent = new Node[](g.n);
    depth = new int[](g.n);
    depth[] = -1;

    struct UP { Node u, p; }
    auto st1 = SList!UP(UP(r, r));
    auto st2 = SList!UP();
    while (!st1.empty) {
      auto up = st1.front, u = up.u, p = up.p; st1.removeFront();

      parent[u] = p;
      depth[u] = depth[p] + 1;

      foreach (v; g[u])
        if (v != p) {
          st1.insertFront(UP(v, u));
          st2.insertFront(UP(v, u));
        }
    }

    size = new int[](g.n);
    size[] = 1;

    while (!st2.empty) {
      auto up = st2.front, u = up.u, p = up.p; st2.removeFront();
      size[p] += size[u];
    }

    return this;
  }

  auto children(Node u) { return g[u].filter!(v => v != parent[u]); }
}
ref auto makeTree(Graph)(ref Graph g) { return Tree!Graph(g); }
