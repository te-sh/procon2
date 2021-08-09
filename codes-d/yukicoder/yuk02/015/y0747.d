// URL: https://yukicoder.me/problems/no/747

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string ns; io.getV(ns);
  string ks; io.getV(ks);

  auto N = ns.map!(c => cast(int)(c-'0')).array;
  auto K = ks.map!(c => cast(int)(c-'0')).array;

  auto nm2 = N[$-1]%2, nm3 = N.sum%3, km2 = K[$-1]%2;
  auto nm6 = [[0,4,2],[3,1,5]][nm2][nm3];
  auto nkm6 = [[0,1,4,3,4,1],[0,1,2,3,4,5]][km2][nm6];

  io.put("428571"[nkm6]);
}

auto io = IO!()();
import lib.io;
