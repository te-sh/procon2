module lib.bound_by;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.bound_by
pure nothrow @nogc @safe
{
  /**
   ** a の要素を conv によって変換したものを comp で比較した結果 v を上回らない
   ** 範囲を a の要素で返します.
   **/
  auto lowerBoundBy(alias conv = "a", alias comp = "a<b", R, T)(R a, T v)
  { return a.sortedTuple!(conv, comp).lowerBound(tuple(a.front, v)).map!"a[0]"; }

  /**
   ** a の要素を conv によって変換したものを comp で比較した結果 v を下回らない
   ** 範囲を a の要素で返します.
   **/
  auto upperBoundBy(alias conv = "a", alias comp = "a<b", R, T)(R a, T v)
  { return a.sortedTuple!(conv, comp).upperBound(tuple(a.front, v)).map!"a[0]"; }

  /**
   ** a の要素を conv によって変換したものを comp で比較する SortedRange を
   ** 返します.
   **/
  auto sortedTuple(alias conv = "a", alias comp = "a<b", R)(R a)
  {
    import std.functional;
    alias convFun = unaryFun!conv, compFun = binaryFun!comp;
    return a.map!(e => tuple(e, convFun(e))).assumeSorted!((a, b) => compFun(a[1], b[1]));
  }
}
// ::::::::::::::::::::

unittest
{
  assert(10.iota.lowerBoundBy!"a*2"(16).back == 7);
  assert(10.iota.lowerBoundBy!("a*2", "a<=b")(16).back == 8);

  assert(10.iota.upperBoundBy!"a*2"(16).front == 9);
  assert(10.iota.upperBoundBy!("a*2", "a<=b")(16).front == 8);
}
