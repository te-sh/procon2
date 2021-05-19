module lib.minmax;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.minmax
pragma(inline) pure nothrow @nogc @safe
{
  /**
   ** a = min(a, b) を計算します.
   **/
  T minU(T, U)(ref T a, U b)
  { return a = min(a, b); }
  /**
   ** a = min(a, b) を計算します.
   **/
  T maxU(T, U)(ref T a, U b)
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

  a.maxU(15);
  assert(a == 15);
  a.maxU(5);
  assert(a == 15);
}