// URL: https://atcoder.jp/contests/abc136/tasks/abc136_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] H; io.getA(N, H);

  foreach_reverse (i; 0..N-1) {
    if (H[i] > H[i+1]+1) io.put!"{exit: true}"("No");
    else if (H[i] == H[i+1]+1) --H[i];
  }

  io.put("Yes");
}

auto io = IO!()();
import lib.io;
