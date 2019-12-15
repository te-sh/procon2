// URL: https://atcoder.jp/contests/abc131/tasks/abc131_f

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  int[] x, y; io.getC(n, x, y); --x[]; --y[];

  const m = 10^^5;
  auto g = Graph(m*2);
  foreach (xi, yi; lockstep(x, y))
    g.addEdgeB(xi, yi+m);

  auto b = new bool[](m*2), r = 0L;
  foreach (u; 0..m) {
    if (b[u]) continue;

    b[u] = true;
    auto v = new g.Node[](0); v ~= u;
    auto s = DList!(g.Node)(); s.insertBack(u);

    while (!s.empty) {
      auto i = s.front; s.removeFront();
      foreach (j; g[i]) {
	if (b[j]) continue;
	b[j] = true;
	v ~= j;
	s.insertBack(j);
      }
    }
    if (v.length == 1) continue;

    auto vx = v.filter!(vi => vi < m).array;
    auto vxe = vx.map!(vxi => g[vxi].length).sum;
    r += vx.length * (v.length - vx.length) - vxe;
  }

  io.put(r);
}

struct Graph
{
  alias Node = int;
  Node n;
  Node[][] g;
  alias g this;
  this(Node n) { this.n = n; g = new Node[][](n); }
  void addEdge(Node u, Node v) { g[u] ~= v; }
  void addEdgeB(Node u, Node v) { g[u] ~= v; g[v] ~= u; }
}

auto io = IO();

struct IO
{
  import std.algorithm, std.conv, std.format, std.range, std.stdio, std.traits;

  dchar[] buf;
  auto sp = (new dchar[](0)).splitter;
  int precision = 10;
  string delimiter = " ";

  void nextLine()
  {
    stdin.readln(buf);
    sp = buf.splitter;
  }

  auto get(T)(ref T v)
  {
    if (sp.empty) nextLine();
    v = sp.front.to!T;
    sp.popFront();
  }

  auto getV(T...)(ref T v)
  {
    foreach (ref w; v) get(w);
  }

  auto getA(T)(size_t n, ref T v)
  {
    v = new T(n);
    foreach (ref w; v) get(w);
  }

  auto getC(T...)(size_t n, ref T v)
  {
    foreach (ref w; v)
      w = new typeof(w)(n);
    foreach (i; 0..n)
      foreach (ref w; v) get(w[i]);
  }

  auto getM(T)(size_t r, size_t c, T v)
  {
    v = new T(r, c);
    foreach (ref w; v) getA(c, w);
  }

  auto putA(T)(T v)
  {
    static if (isInputRange!T && hasLength!T && !isSomeString!T) {
      foreach (i, w; v) {
	putA(w);
	if (i < v.length - 1) write(delimiter);
      }
    } else if (isFloatingPoint!T) {
      writef(format("%%.%df", precision), v);
    } else {
      write(v);
    }
  }

  auto put(T...)(T v)
  {
    foreach (i, w; v) {
      putA(w);
      if (i < v.length - 1) write(delimiter);
    }
    writeln;
  }

  auto putB(S, T)(bool c, S t, T f)
  {
    if (c)
      put(t);
    else
      put(f);
  }

  auto dbg(T...)(T v)
  {
    stderr.writeln(v);
  }
}
