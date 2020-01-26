// URL: https://yukicoder.me/problems/no/660

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  
  auto fact = Fact!mint(N*2);

  auto ans = mint(0);
  for (auto k = N; k <= N*2; k += 2) {
    auto a = (k+N)/2, b = (k-N)/2;
    ans += fact.combi(a+b-1, b) - fact.combi(a+b-1, b-1);
  }

  io.put(ans);
}

import lib.math.fact;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
