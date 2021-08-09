// URL: https://yukicoder.me/problems/no/38

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int Kr, Kb; io.getV(Kr, Kb);
  string S; io.getV(S);

  auto n = 10, r = size_t(0);
 loop: foreach (i; 0..1<<(n*2)) {
    auto j = 0, k = 0, t = new dchar[](n*3-i.popcnt);
    foreach (c; 0..n*3) {
      switch (S[c]) {
      case 'W':
        t[j++] = 'W';
        break;
      case 'R':
        if (!i.bitTest(k++)) {
          if (j >= Kr && t[j-Kr] == 'R') continue loop;
          t[j++] = 'R';
        }
        break;
      case 'B':
        if (!i.bitTest(k++)) {
          if (j >= Kb && t[j-Kb] == 'B') continue loop;
          t[j++] = 'B';
        }
        break;
      default:
        assert(0);
      }
    }
    r = max(r, t.length);
  }

  io.put(r);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
