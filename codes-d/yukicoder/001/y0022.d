// URL: https://yukicoder.me/problems/no/22

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  string S; io.getV(S);
  auto c = S.map!(si => si == '(' ? +1 : -1).array.cumulativeSum;

  if (S[K-1] == '(') {
    foreach (i; K..N+1)
      if (c[K-1..i] == 0) {
	io.put(i);
	return;
      }
  } else {
    foreach_reverse (i; 0..K)
      if (c[i..K] == 0) {
	io.put(i+1);
	return;
      }
  }
}

import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
