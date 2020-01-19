// URL: https://yukicoder.me/problems/no/3

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto b = new int[](N+1), inf = 10^^9;
  b[] = inf; b[1] = 1;

  auto q = DList!int(1);
  while (!q.empty) {
    auto i = q.front; q.removeFront();
    auto j1 = i-i.popcnt, j2 = i+i.popcnt;
    if (j1 >= 1 && b[j1] > b[i]+1) {
      b[j1] = b[i]+1;
      q.insertBack(j1);
    }
    if (j2 <= N && b[j2] > b[i]+1) {
      b[j2] = b[i]+1;
      q.insertBack(j2);
    }
  }

  io.putB(b[N] != inf, b[N], -1);
}

pragma(inline)
{
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }

  import core.bitop;
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
  pure int popcnt(T)(T n) { return core.bitop.popcnt(ulong(n)); }
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