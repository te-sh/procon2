// URL: https://yukicoder.me/problems/no/658

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int Q; io.getV(Q);

  auto a = matrix!mint([[1,1,1,1],[1,0,0,0],[0,1,0,0],[0,0,1,0]]);
  foreach (_; 0..Q) {
    long n; io.getV(n);
    io.putB(n < 4, 0, (a^^(n-4))[0][0]);
  }
}

import lib.math.matrix;

const mod = 17;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
