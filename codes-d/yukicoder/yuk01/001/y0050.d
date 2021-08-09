// URL: https://yukicoder.me/problems/no/50

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);
  int M; io.getV(M);
  int[] B; io.getA(M, B);

  A.sort; B.sort!"a>b";

  auto r = M+1;
 loop: do {
    auto i = 0, s = B[i];
    foreach (Ai; A) {
      if (Ai > s) {
        ++i;
        if (i == M) continue loop;
        s = B[i];
        if (Ai > s) continue loop;
      }
      s -= Ai;
    }
    r = min(r, i+1);
  } while (nextPermutation(A));

  io.putB(r <= M, r, -1);
}

auto io = IO!()();
import lib.io;
