import std.traits;
pure T powr(alias pred = "a * b", T, U)(T a, U n, T init = T(1))
if (isIntegral!U)
{
  import std.functional;
  alias predFun = binaryFun!pred;

  auto r = init;
  if (n == 0) return r;

  for (; n > 0; n >>= 1) {
    if (n&1) r = predFun(r, a);
    a = predFun(a, a);
  }

  return r;
}

/*

  a.powr(n)

    a の n 乗を返します.
    内部では繰り返し2乗法を使っています.

 */

unittest
{
  assert(2.powr(0) == 1);
  assert(2.powr(1) == 2);
  assert(2.powr(5) == 32);
}
