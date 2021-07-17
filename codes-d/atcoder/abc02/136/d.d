// URL: https://atcoder.jp/contests/abc136/tasks/abc136_d

import std;

version(unittest) {} else
void main()
{
  string S; io.getV(S);

  auto c = new int[](S.length), i = 0;
  foreach (m; S.matchAll(r"(R+)L+")) {
    auto l = m[0].length.to!int, r = m[1].length.to!int;
    foreach (j; 0..l)
      ++c[i + (abs(r - j)%2 == 0 ? r : r-1)];
    i += l;
  }

  io.put(c);
}

auto io = IO!()();
import lib.io;
