// URL: https://yukicoder.me/problems/no/194

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; long K; io.getV(N, K);
  int[] A; io.getA(N, A);

  if (K <= 10^^6) {
    auto f = new mint[](K);
    foreach (i, Ai; A) f[i] = Ai;
    f[N] = f[0..N].sum;
    foreach (i; N+1..K) f[i] = f[i-1]*2-f[i-N-1];
    io.put(f[$-1], f.sum);
  } else {
    auto m = Matrix(N+1, N+1);
    foreach (i; 1..N) m[i-1][i] = 1;
    foreach (i; 0..N) { m[N-1][i] = 1; m[N][i] = 1; }
    m[N][N] = 1;
    auto v = Vector(N+1);
    foreach (i, Ai; A) v[i] = Ai;
    v[N] = v[0..N].sum;
    auto r = m^^(K-N)*v;
    io.put(r[N-1], r[N]);
  }
}

alias me = MatrixElement!(mint, mint(0), mint(1)), Matrix = me.Matrix, Vector = me.Vector;
import lib.math.matrix;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
