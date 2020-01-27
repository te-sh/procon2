// URL: https://yukicoder.me/problems/no/689

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int K; io.getV(K);

  int[] a;
  calc1(K, a);
  calc2(K, a);
  calc3(K, a);

  if (a.empty) a ~= 1;

  io.put(a.length);
  io.put(a);
}

auto calc1(ref int k, ref int[] a)
{
  if (k < 100) return;

  a ~= 2.repeat.take(k/100).array;
  a ~= 3.repeat.take(100).array;

  k %= 100;
}

auto calc2(ref int k, ref int[] a)
{
  if (k < 10) return;

  a ~= 6.repeat.take(k/10).array;
  a ~= 7.repeat.take(10).array;

  k %= 10;
}

auto calc3(ref int k, ref int[] a)
{
  if (k == 0) return;

  a ~= 18;
  a ~= 19.repeat.take(k).array;
}

auto io = IO!()();
import lib.io;
