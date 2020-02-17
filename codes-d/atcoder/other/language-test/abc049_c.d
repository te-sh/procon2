// URL: https://atcoder.jp/contests/language-test-202001/tasks/arc065_a

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string s; io.getV(s);

 loop: while (s.length > 0) {
    foreach (t; ["dream", "dreamer", "erase", "eraser"]) {
      if (s.length >= t.length && s[$-t.length..$] == t) {
        s = s[0..$-t.length];
        continue loop;
      }
    }
    io.put!"{exit: true}"("NO");
  }
  io.put("YES");
}

auto io = IO!()();
import lib.io;
