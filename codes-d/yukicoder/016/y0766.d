// URL: https://yukicoder.me/problems/no/766

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M, P; io.getV(N, M, P);
  int[] V; io.getA(N, V);

  V.sort!"a>b";

  auto w = new mint[](N);
  foreach (i; 0..N) w[i] = V[i];
  auto wc = w.cumulativeSum;

  auto pp = new mint[](M+1); pp[0] = 1;
  foreach (i; 1..M+1) pp[i] = pp[i-1] * P / 100;
  auto p1p = new mint[](N+1); p1p[0] = 1;
  foreach (i; 1..N+1) p1p[i] = p1p[i-1] * (100-P) / 100;

  auto fact = Fact!mint(N+M);

  auto r = mint(0);
  foreach (i; 0..M)
    r += wc[0..N] * fact.combi(N-1+i, i) * p1p[N] * pp[i];
  foreach (i; 0..N)
    r += wc[0..i] * fact.combi(M-1+i, i) * p1p[i] * pp[M];

  io.put(r);
}

import lib.data_structure.cumulative_sum;

import lib.math.fact;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
