// URL: https://atcoder.jp/contests/arc049/tasks/arc049_c

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
  int a; readV(a);
  int[] x, y; readC(a, x, y); --x[]; --y[];
  int b; readV(b);
  int[] u, v; readC(b, u, v); --u[]; --v[];

  auto r = 0;
  foreach (i; 0..1<<b) {
    auto g = Graph!int(n), t = new bool[](n);

    foreach (j; 0..a)
      g.addEdge(y[j], x[j]);

    foreach (j; 0..b)
      if (i.bitTest(j))
        g.addEdge(u[j], v[j]);
      else
        t[u[j]] = true;

    foreach (sc; g.stronglyConnectedComponentsGabow)
      if (sc.length > 1)
        foreach (sci; sc)
          t[sci] = true;

    foreach (j; 0..n)
      if (t[j]) {
        auto q = DList!int(j);
        while (!q.empty) {
          auto c = q.front; q.removeFront();
          foreach (d; g[c])
            if (!t[d]) {
              t[d] = true;
              q.insert(d);
            }
        }
      }

    r = max(r, t.count(false).to!int);
  }

  writeln(r);
}

pragma(inline) {
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }

  pure T bitSet(T)(T n, size_t s, size_t e) { return n | ((T(1) << e) - 1) & ~((T(1) << s) - 1); }
  pure T bitReset(T)(T n, size_t s, size_t e) { return n & (~((T(1) << e) - 1) | ((T(1) << s) - 1)); }
  pure T bitComp(T)(T n, size_t s, size_t e) { return n ^ ((T(1) << e) - 1) & ~((T(1) << s) - 1); }

  import core.bitop;
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
  pure int popcnt(T)(T n) { return core.bitop.popcnt(ulong(n)); }
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

auto stronglyConnectedComponentsGabow(Graph)(ref Graph g)
{
  import std.container, std.conv;

  alias Node = g.Node;
  auto n = g.n;

  Node[][] scc;
  Node[] i = new Node[](n);
  auto s = SList!Node(), b = SList!Node(), ns = Node(0);

  void dfs(Node u)
  {
    b.insert(i[u] = ns);
    s.insert(u); ++ns;
    foreach (v; g[u]) {
      if (!i[v]) dfs(v);
      else while (i[v] < b.front) b.removeFront;
    }
    if (i[u] == b.front) {
      scc ~= [[]];
      b.removeFront;
      while (i[u] < ns) {
        scc[$-1] ~= s.front;
        i[s.front] = n + scc.length.to!Node;
        s.removeFront; --ns;
      }
    }
  }

  foreach (u; 0..n)
    if (!i[u]) dfs(u);

  return scc;
}
