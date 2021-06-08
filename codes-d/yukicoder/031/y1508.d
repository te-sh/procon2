// URL: https://yukicoder.me/problems/no/1508

import std;

version(unittest) {} else
void main()
{
  int N, Q; io.getV(N, Q);
  int[] A; io.getA(Q, A); --A[];
  int[] B; io.getA(Q, B); --B[];

  auto s = new Section!int[][](Q+1);
  s[0] ~= section(0, N);

  foreach (i, Ai, Bi; lockstep(A, B)) {
    if (Ai > Bi) swap(Ai, Bi);
    foreach (si; s[i]) {
      auto t = section(max(0, si.start-1), min(N, si.end+1));

      auto avoidHit(Section!int t, int a)
      {
        if (t.include(a)) {
          if (t.length == 1) return section(-1, 0);
          if (a == t.start) {
            t = section(t.start+1, t.end);
          } else if (a == t.end-1) {
            t = section(t.start, t.end-1);
          } else {
            auto ta = section(t.start, a);
            if (!s[i+1].empty && mergeable(s[i+1].back, ta))
              s[i+1][$-1] = merge(s[i+1][$-1], ta);
            else
              s[i+1] ~= ta;
            t = section(a+1, t.end);
          }
        }
        return t;
      }

      t = avoidHit(t, Ai);
      if (t.start == -1) continue;
      t = avoidHit(t, Bi);
      if (t.start == -1) continue;

      if (!s[i+1].empty && mergeable(s[i+1].back, t))
        s[i+1][$-1] = merge(s[i+1][$-1], t);
      else
        s[i+1] ~= t;
    }
  }

  if (s[$-1].empty) {
    io.put("NO");
  } else {
    auto r = new int[](Q+1), i = 0;
    for (; i < N; ++i)
      if (s[$-1].any!(si => si.include(i)))
        break;
    r[0] = i;

    foreach (j; 0..Q) {
      for (auto k = i-1; k <= i+1; ++k)
        if (s[$-j-2].any!(si => si.include(k))) {
          r[j+1] = i = k;
          break;
        }
    }

    io.put("YES");
    foreach_reverse (ri; r) io.put(ri+1);
  }
}

import lib.data_structure.section;

auto io = IO!()();
import lib.io;
