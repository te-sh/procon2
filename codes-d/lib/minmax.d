module lib.minmax;
import std;

// :::::::::::::::::::: lib.minmax
pragma(inline) pure nothrow @nogc @safe
{
  /**
   ** a = min(a, b) を計算します.
   **/
  ref T minU(T, U)(ref T a, U b)
  { return a = min(a, b); }
  /**
   ** a = min(a, b) を計算します.
   **/
  ref T maxU(T, U)(ref T a, U b)
  { return a = max(a, b); }
}
// ::::::::::::::::::::

unittest
{
  auto a = 10;

  a.minU(15);
  assert(a == 10);
  a.minU(5);
  assert(a == 5);
  a.minU(6).minU(3);
  assert(a == 3);

  a.maxU(15);
  assert(a == 15);
  a.maxU(5);
  assert(a == 15);
  a.maxU(18).maxU(20);
  assert(a == 20);
}
