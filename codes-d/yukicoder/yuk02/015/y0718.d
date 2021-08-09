// URL: https://yukicoder.me/problems/no/718

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);

  auto m = matrix!mint([[1,1,0,0],[0,1,1,2],[0,1,0,0],[0,1,0,1]]);
  io.put((m^^N)[0][1]);
}

import lib.math.misc;

import lib.math.matrix;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
