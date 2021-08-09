// URL: https://yukicoder.me/problems/no/1505

import std;

version(unittest) {} else
void main()
{
  long N; io.getV(N);
  int[] A; io.getA(N, A);

  auto c = 0L;
  foreach (block; A.chunkBy!"a==b") {
    if (block.front == 1) {
      auto n = block.walkLength;
      c += (n+1) * n / 2;
    }
  }

  io.put((N+1) * N / 2 - c);
}

auto io = IO!()();
import lib.io;

