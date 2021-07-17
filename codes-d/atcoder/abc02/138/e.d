// URL: https://atcoder.jp/contests/abc138/tasks/abc138_e

import std;

version(unittest) {} else
void main()
{
  string ss; io.getV(ss);
  string st; io.getV(st);

  auto s = ss.map!(si => (si-'a').to!int).array;
  auto t = st.map!(ti => (ti-'a').to!int).array;
  auto ns = s.length.to!long, nt = t.length.to!long;

  auto c = new long[][](26);
  foreach (i, si; s)
    c[si] ~= i.to!long;

  auto i = -1L, j = 0L;
  foreach (ti; t) {
    if (c[ti].empty)
      io.put!"{exit: true}"(-1);
    auto k = c[ti].assumeSorted.upperBound(i);
    if (k.empty) {
      ++j;
      k = c[ti].assumeSorted.upperBound(-1);
    }
    i = k.front;
  }

  io.put(ns*j+i+1);
}

auto io = IO!()();
import lib.io;
