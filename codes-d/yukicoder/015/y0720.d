// URL: https://yukicoder.me/problems/no/720

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long N; int M; io.getV(N, M);

  auto a = matrix!mint([[1,1,0],[0,1,1],[0,1,0]]);
  auto b = matrix!mint([[1,0,0],[0,1,1],[0,1,0]]);

  io.put(((a*b^^(M-1))^^N)[0][1]);
}

import lib.math.misc;

import lib.math.matrix;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
