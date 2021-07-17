// URL: https://atcoder.jp/contests/abc172/tasks/abc172_e

import std;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);

  auto f = Fact!mint(M);

  auto r = f.perm(M, N);
  foreach (i; 1..N+1)
    r -= f.perm(M-i, N-i) * f.combi(N, i) * (i%2 == 0 ? -1 : 1);

  io.put(f.perm(M, N) * r);
}

const mod = 10^^9+7;
alias mint = ModInt!mod;

import lib.math.fact;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
