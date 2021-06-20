// URL: https://atcoder.jp/contests/aising2020/tasks/aising2020_d

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  dchar[] X; io.getV(X); X.reverse;

  auto f = new int[](N+1);
  foreach (i; 1..N+1)
    f[i] = f[i % i.popcnt]+1;

  auto p = X.count('1').to!int, pn = p-1, pp = p+1;
  auto mn = new int[](N); mn[0] = pn == 1 ? 0 : 1;
  auto mp = new int[](N); mp[0] = pp == 1 ? 0 : 1;
  foreach (i; 1..N) {
    if (pn != 0)
      (mn[i] = mn[i-1]*2) %= pn;
    (mp[i] = mp[i-1]*2) %= pp;
  }

  auto Xmn = 0, Xmp = 0;
  foreach (i; 0..N)
    if (X[i] == '1') {
      if (pn != 0)
        (Xmn += mn[i]) %= pn;
      (Xmp += mp[i]) %= pp;
    }

  auto r = new int[](N);
  foreach (i; 0..N) {
    if (X[i] == '0')
      r[i] = f[(Xmp+mp[i])%pp]+1;
    else
      if (pn != 0)
        r[i] = f[(Xmn-mn[i]+pn)%pn]+1;
  }

  foreach_reverse (ri; r) io.put(ri);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
