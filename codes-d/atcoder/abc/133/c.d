// URL: https://atcoder.jp/contests/abc133/tasks/abc133_c

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int l, r; io.getV(l, r);

  auto m = 2019;
  foreach (i; l..min(l+2019, r+1))
    foreach (j; i+1..min(i+2020, r+1))
      m = min(m, ((i%2019)*(j%2019))%2019);

  io.put(m);
}

auto io = IO();

struct IO
{
  import std.algorithm, std.conv, std.format, std.meta, std.range, std.stdio, std.traits;

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
  if (hasAssignableElements!T)
  {
    v = new T(n);
    foreach (ref w; v) get(w);
  }

  auto getC(T...)(size_t n, ref T v)
  if (allSatisfy!(hasAssignableElements, T))
  {
    foreach (ref w; v)
      w = new typeof(w)(n);
    foreach (i; 0..n)
      foreach (ref w; v) get(w[i]);
  }

  auto getM(T)(size_t r, size_t c, ref T v)
  if (hasAssignableElements!T && hasAssignableElements!(ElementType!T))
  {
    v = new T(r);
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
