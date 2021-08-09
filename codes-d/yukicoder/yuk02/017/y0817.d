// URL: https://yukicoder.me/problems/no/817

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] A, B; io.getC(N, A, B);
  auto Am = A.dup; Am[] -= 1;
  auto Bp = B.dup; Bp[] += 1;

  auto z = Zaatsu!int(Am, A, B, Bp), c = new int[](z.n+1);
  foreach (Ai, Bi; lockstep(A, B)) {
    ++c[z.comp(Ai)];
    --c[z.comp(Bi+1)];
  }
  foreach (i; 0..z.n)
    c[i+1] += c[i];

  foreach (i, ci; c[0..$-1]) {
    auto j = i.to!int;
    auto m = ci*(z.uncomp(j+1)-z.uncomp(j));
    if (K > m) {
      K -= m;
    } else {
      io.put!"{exit: true}"(z.uncomp(j) + (K-1)/ci);
    }
  }
}

import lib.data_structure.zaatsu;

auto io = IO!()();
import lib.io;
