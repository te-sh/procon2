// URL: http://codeforces.com/contest/964/problem/D

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] p; readA(n, p); p[] -= 1;

  if (n%2 == 0) {
    writeln("NO");
    return;
  }

  auto g = Graph!int(n);
  foreach (int i, pi; p)
    if (pi != -1) g.addEdgeB(i, pi);
  auto t = g.makeTree.rootify(0);

  auto c = new int[](n), qu = DList!int([0]), st = SList!int();
  while (!qu.empty) {
    auto u = qu.front; qu.removeFront();
    st.insertFront(u);
    foreach (v; t.children(u)) qu.insertBack(v);
  }
  while (!st.empty) {
    auto u = st.front; st.removeFront();
    c[u] = 1;
    foreach (v; t.children(u)) c[u] += c[v];
  }

  writeln("YES");

  st.insertFront(0);
  while (!st.empty) {
    auto u = st.front; st.removeFront();
    if (u >= n) {
      writeln(u-n+1);
      continue;
    }
    foreach (v; t.children(u).filter!(v => c[v]%2 == 1))
      st.insertFront(v);
    st.insertFront(u+n);
    foreach (v; t.children(u).filter!(v => c[v]%2 == 0))
      st.insertFront(v);
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
