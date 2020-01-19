// URL: https://yukicoder.me/problems/no/783

import std.algorithm, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n, c; io.getV(n, c);
  int[] l; io.getA(n, l);
  int[] w; io.getA(n, w);

  auto ml = l.maxElement, dp = new int[][][](c+1, ml+1, ml+1);
  foreach (li1, wi1; lockstep(l, w))
    foreach (li2, wi2; lockstep(l, w))
      foreach (li3, wi3; lockstep(l, w))
        if (li1 != li2 && li2 != li3 && li3 != li1 && (li1 > li2 && li2 < li3 || li1 < li2 && li2 > li3) && c-wi1-wi2-wi3 >= 0)
          dp[c-wi1-wi2-wi3][li2][li3] = max(dp[c-wi1-wi2-wi3][li2][li3], li1+li2+li3);

  foreach_reverse (i; 1..c+1)
    foreach (j2; 1..ml+1)
      foreach (j1; 1..ml+1)
        foreach (li, wi; lockstep(l, w))
          if (dp[i][j2][j1] > 0 && j2 != li && j1 != li && (j2 > j1 && j1 < li || j2 < j1 && j1 > li) && i-wi >= 0)
            dp[i-wi][j1][li] = max(dp[i-wi][j1][li], dp[i][j2][j1]+li);

  io.put(dp.map!(d1 => d1.map!(d2 => d2.maxElement).maxElement).maxElement);
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
