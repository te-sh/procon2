// URL: https://atcoder.jp/contests/language-test-202001/tasks/practice_2

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.functional;

version(unittest) {} else
void main()
{
  int N, Q; io.getV(N, Q);

  auto d = new dchar[](N);
  foreach (i, ref di; d) di = 'A'+cast(int)i;

  if (N == 5)
    d.sort!((a, b) => memoize!query(a, b));
  else
    d = d.mergeSort;

  io.put("!", d);
}

bool query(dchar a, dchar b)
{
  if (a > b) return !memoize!query(b, a);
  io.put!"{flush: true}"("?", a, b);
  string ans; io.getV(ans);
  return ans == "<";
}

dchar[] mergeSort(dchar[] d)
{
  if (d.length == 1) return d;

  auto d1 = mergeSort(d[0..d.length/2]);
  auto d2 = mergeSort(d[d.length/2..$]);

  auto r = cast(dchar[])[], i1 = 0, i2 = 0;
  while (i1 < d1.length || i2 < d2.length) {
    if (i1 == d1.length) {
      r ~= d2[i2++];
    } else if (i2 == d2.length) {
      r ~= d1[i1++];
    } else if (memoize!query(d1[i1], d2[i2])) {
      r ~= d1[i1++];
    } else {
      r ~= d2[i2++];
    }
  }

  return r;
}

auto io = IO!()();
import lib.io;
