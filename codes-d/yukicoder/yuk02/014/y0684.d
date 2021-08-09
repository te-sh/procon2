// URL: https://yukicoder.me/problems/no/684

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);
  string S; io.getV(S);

  auto a = new long[](N);
  foreach (i; 0..N) a[i] = S[i] == '(' ? 1 : -1;
  foreach (i; 1..N) a[i] = a[i-1] + a[i];

  struct AM { long a, m; }
  auto am = new AM[](N), m = 0L;
  foreach (i; 0..N) {
    m = min(m, a[i]);
    am[i] = AM(a[i], m);
  }

  am.sort!((a, b) => min(a.m, a.a+b.m) > min(b.m, b.a+a.m));
  auto ami = am[0];
  foreach (i; 1..N) {
    ami.m = min(ami.m, ami.a + am[i].m);
    ami.a += am[i].a;
  }

  io.put(N*(N+1)/2 - ami.a + ami.m*2);
}

auto io = IO!()();
import lib.io;
