// URL: https://yukicoder.me/problems/no/726

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  auto primes = Prime(10^^5);

  int Y, X; io.getV(Y, X);

  if (Y == 2 || X == 2) io.put!"{exit: true}"("Second");

  auto isPrime(int n)
  {
    if (n == 1) return false;

    foreach (pi; primes) {
      if (pi > n.isqrt) break;
      if (n%pi == 0) return false;
    }

    return true;
  }

  auto nextPrime(int n)
  {
    ++n;
    for (;; ++n) if (isPrime(n)) return n;
    assert(0);
  }

  auto yp = isPrime(Y), xp = isPrime(X);
  if (yp && xp) io.put!"{exit: true}"("Second");

  auto ny = nextPrime(Y), nx = nextPrime(X);
  auto t = (ny-Y)+(nx-X);
  io.putB(t%2 != 0, "First", "Second");
}

import lib.math.misc;

import lib.math.prime;

auto io = IO!()();
import lib.io;
