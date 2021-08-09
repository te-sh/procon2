// URL: https://yukicoder.me/problems/no/673

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long B, C, D; io.getV(B, C, D);

  auto a = matrix!mint([[mint(C), mint(B)*mint(C)], [mint(0), mint(1)]]);
  auto r = a^^D;

  io.put(r[0][1]);
}

import lib.math.matrix;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
