// URL: https://yukicoder.me/problems/no/9

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);
  int[] B; io.getA(N, B); B[] /= 2;

  struct M { int lv, c; }

  auto fight(R)(R b)
  {
    auto m = heapify!"a.lv==b.lv ? a.c>b.c : a.lv>b.lv"(A.map!(Ai => M(Ai, 0)).array);
    foreach (bi; b) {
      auto mi = m.front;
      m.replaceFront(M(mi.lv+bi, mi.c+1));
    }
    return m.map!"a.c".maxElement;
  }

  io.put(N.iota.map!(i => fight(B.cycle.drop(i).take(N))).minElement);
}

auto io = IO!()();

import std.stdio;
struct IO(alias IN = stdin, alias OUT = stdout, string delimiter = " ", string floatFormat = "%.10f")
{
  import std.algorithm, std.conv, std.format, std.meta, std.range, std.traits;
  alias assignable = hasAssignableElements;

  dchar[] buf;
  auto sp = (new dchar[](0)).splitter;
  void nextLine() { IN.readln(buf); sp = buf.splitter; }

  auto get(T)(ref T v) { if (sp.empty) nextLine(); v = sp.front.to!T; sp.popFront(); }
  auto getV(T...)(ref T v) { foreach (ref w; v) get(w); }
  auto getA(T)(size_t n, ref T v) if (assignable!T) { v = new T(n); foreach (ref w; v) get(w); }
  auto getC(T...)(size_t n, ref T v) if (allSatisfy!(assignable, T))
  {
    foreach (ref w; v) w = new typeof(w)(n);
    foreach (i; 0..n) foreach (ref w; v) get(w[i]);
  }
  auto getM(T)(size_t r, size_t c, ref T v) if (assignable!T && assignable!(ElementType!T))
  {
    v = new T(r); foreach (ref w; v) getA(c, w);
  }

  auto putR(T)(T v)
  {
    auto w = v;
    while (!w.empty) { putA(w.front); w.popFront(); if (!w.empty) OUT.write(delimiter); }
  }
  auto putA(T)(T v)
  {
    static if (isInputRange!T && !isSomeString!T) putR(v);
    else if (isFloatingPoint!T) OUT.write(format(floatFormat, v));
    else OUT.write(v);
  }
  auto put(T...)(T v)
  {
    foreach (i, w; v) { putA(w); if (i < v.length-1) OUT.write(delimiter); }
    OUT.writeln;
  }

  auto putB(S, T)(bool c, S t, T f) { if (c) put(t); else put(f); }
  auto putRaw(T...)(T v) { OUT.write(v); OUT.writeln; }
}
