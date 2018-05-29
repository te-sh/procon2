// URL: http://codeforces.com/contest/960/problem/E

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

const mod = 10^^9+7;
alias mint = FactorRing!mod;

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] w; readA(n, w);

  auto g = Graph!int(n);
  foreach (_; 0..n-1) {
    int u, v; readV(u, v);
    g.addEdgeB(--u, --v);
  }
  auto t = makeTree(g).rootify(0);

  auto ei = new int[int][](n);
  foreach (u; 0..n)
    foreach (int i, v; g[u]) ei[u][v] = i;

  auto vc = new VC[][](n), vct = new VC[](n);
  foreach (u; 0..n) vc[u] = new VC[](g[u].length);

  auto q = DList!int([0]), rt = new int[](0);
  while (!q.empty) {
    auto u = q.front; q.removeFront();
    rt ~= u;
    foreach (v; t[u])
      if (v != t.parent[u])
        q.insertBack(v);
  }
  rt = rt[1..$];

  foreach_reverse (u; rt) {
    auto p = t.parent[u];
    auto vci = VC(1, 0);
    foreach (i, v; g[u])
      if (v != p)
        vci = vci + vc[u][i].inv;
    vc[p][ei[p][u]] = vci;
  }

  foreach (u; 0..n)
    foreach (vci; vc[u])
      vct[u] = vct[u] + vci;

  foreach (u; rt) {
    auto p = t.parent[u];
    vc[u][ei[u][p]] = VC(1, 0) + (vct[p] - vc[p][ei[p][u]]).inv;
    vct[u] = vct[u] + vc[u][ei[u][p]];
  }

  auto ans = mint(0);
  foreach (u; 0..n) {
    auto vcti = vct[u];
    auto eo = mint(1);
    eo += vcti.o + vcti.e;
    eo += vcti.o - vcti.e;
    foreach (i, v; g[u]) {
      auto vci = vc[u][i], rvci = vcti - vci;
      eo += (mint(vci.o) - vci.e) * (rvci.o + rvci.e);
    }
    ans += eo * w[u];
  }

  writeln(ans);
}

struct VC
{
  int e, o;
  auto inv() { return VC(o, e); }
  auto opBinary(string op: "+")(VC a) { return VC(e+a.e, o+a.o); }
  auto opBinary(string op: "-")(VC a) { return VC(e-a.e, o-a.o); }
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

struct FactorRing(int m, bool pos = false)
{
  version(BigEndian) union { long vl; struct { int vi2; int vi; } } else union { long vl; int vi; }
  alias FR = FactorRing!(m, pos);
  @property static init() { return FR(0); }
  @property int value() { return vi; }
  @property void value(int v) { vi = mod(v); }
  alias value this;

  this(int v) { vi = v; }
  this(int v, bool runMod) { vi = runMod ? mod(v) : v; }
  this(long v) { vi = mod(v); }

  ref auto opAssign(int v) { vi = v; return this; }

  pure auto mod(int v) const { static if (pos) return v%m; else return (v%m+m)%m; }
  pure auto mod(long v) const { static if (pos) return cast(int)(v%m); else return cast(int)((v%m+m)%m); }

  static if (!pos) pure ref auto opUnary(string op: "-")() { return FR(mod(-vi)); }

  static if (m < int.max / 2) {
    pure ref auto opBinary(string op)(int r) if (op == "+" || op == "-") { return FR(mod(mixin("vi"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { vi = mod(mixin("vi"~op~"r")); return this; }
  } else {
    pure ref auto opBinary(string op)(int r) if (op == "+" || op == "-") { return FR(mod(mixin("vl"~op~"r"))); }
    ref auto opOpAssign(string op)(int r) if (op == "+" || op == "-") { vi = mod(mixin("vl"~op~"r")); return this; }
  }
  pure ref auto opBinary(string op: "*")(int r) { return FR(mod(vl*r)); }
  ref auto opOpAssign(string op: "*")(int r) { vi = mod(vl*r); return this; }

  pure ref auto opBinary(string op)(ref FR r) if (op == "+" || op == "-" || op == "*") { return opBinary!op(r.vi); }
  ref auto opOpAssign(string op)(ref FR r) if (op == "+" || op == "-" || op == "*") { return opOpAssign!op(r.vi); }
}
