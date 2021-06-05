// URL: https://atcoder.jp/contests/abc173/tasks/abc173_e

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  long[] A; io.getA(N, A);

  auto B = A.filter!"a>0".array;
  auto C = A.filter!"a<0".array;
  auto D = A.filter!"a==0".array;

  auto f1(int k)
  {
    auto b = B.dup, c = C.dup;
    b.sort!"a>b";
    c.sort!"a<b";
    auto r = mint(1);
    if (k%2 == 1) {
      if (b.length == 0) return tuple(mint(0), false);
      r = b[0];
      b = b[1..$];
    }
    while (k > 0) {
      if (b.length >= 2) {
        if (c.length >= 2) {
          if (b[0]*b[1] > c[0]*c[1]) {
            r *= mint(b[0]*b[1]);
            b = b[2..$];
          } else {
            r *= mint(c[0]*c[1]);
            c = c[2..$];
          }
          k -= 2;
        } else {
          r *= mint(b[0]*b[1]);
          b = b[2..$];
          k -= 2;
        }
      } else {
        if (c.length >= 2) {
          r *= mint(c[0]*c[1]);
          c = c[2..$];
          k -= 2;
        } else {
          return tuple(mint(0), false);
        }
      }
    }
    return tuple(r, true);
  }

  auto f2(int k)
  {
    if (D.length > 0) {
      return tuple(mint(0), true);
    } else {
      return tuple(mint(0), false);
    }
  }

  auto f3(int k)
  {
    auto b = B.dup, c = C.dup;
    if (b.length + c.length < k) return tuple(mint(0), true);
    b.sort!"a<b";
    c.sort!"a>b";
    auto r = mint(1);
    while (k > 0) {
      if (b.length >= 1) {
        if (c.length >= 1) {
          if (abs(b[0]) > abs(c[0])) {
            r *= b[0];
            b = b[1..$];
          } else {
            r *= c[0];
            c = c[1..$];
          }
          --k;
        } else {
          r *= b[0];
          b = b[1..$];
          --k;
        }
      } else {
        if (c.length >= 1) {
          r *= c[0];
          c = c[1..$];
          --k;
        } else {
          return tuple(mint(0), false);
        }
      }
        
    }
    return tuple(r, true);
  }

  auto r1 = f1(K);
  if (r1[1]) io.put!"{exit: true}"(r1[0]);

  auto r2 = f2(K);
  if (r2[1]) io.put!"{exit: true}"(r2[0]);

  auto r3 = f3(K);
  if (r3[1]) io.put!"{exit: true}"(r3[0]);
}

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
