// URL: https://yukicoder.me/problems/no/1514

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto a = new bool[](N+1), b = new int[](N+1);
  a[2..$] = true;
  foreach (i; 1..N+1) b[i] = i;

  foreach (i; 2..isqrt(N)+1) {
    if (!a[i]) continue;
    for (auto j = i*2; j <= N; j += i) a[i] = false;
    auto i2 = i*i;
    for (auto j = i2; j <= N; j += i*i)
      while (b[j] % i2 == 0) b[j] /= i2;
  }

  auto c = new int[](N+1);
  foreach (bi; b[1..N+1]) ++c[bi];

  io.put(c.map!"a*a".sum);
}

import lib.math.isqrt;

auto io = IO!()();
import lib.io;
