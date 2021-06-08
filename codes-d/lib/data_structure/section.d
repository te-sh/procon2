module lib.data_structure.section;
import std;

// :::::::::::::::::::: lib.data_structure.section
/**
 ** 区間を表します. 区間は右半開区間です.
 **/
struct Section(T)
{
  /**
   ** 区間の開始および終了です.
   **/
  T start, end;

  /**
   ** 区間を返します.
   ** start < end である必要があります.
   **/
  pure nothrow @nogc @safe
  {
    this(T start, T end)
      in { assert(start < end); }
    do
    {
      this.start = start;
      this.end = end;
    }
  }
}

pure nothrow @nogc @safe
{
  /**
   ** 区間を返します.
   ** start < end である必要があります.
   **/
  auto section(T)(T start, T end)
    in { assert(start < end); }
  do
  {
    return Section!T(start, end);
  }

  /**
   ** 区間 a, b に重なりがあるかどうかを返します.
   **/
  bool overlaped(T)(Section!T a, Section!T b)
  {
    return a.start < b.end && a.end > b.start;
  }
  /**
   ** 区間 a, b が結合可能かどうかを返します.
   **/
  bool mergeable(T)(Section!T a, Section!T b)
  {
    return overlaped(a, b) || a.start == b.end || a.end == b.start;
  }
  /**
   ** 区間 a, b を結合した区間を返します.
   ** 区間 a, b は結合可能である必要があります.
   **/
  auto merge(T)(Section!T a, Section!T b)
    in { assert(mergeable(a, b)); }
  do
  {
    return section(min(a.start, b.start), max(a.end, b.end));
  }
}
// ::::::::::::::::::::

unittest
{
  auto a = Section!int(3, 10);
  assert(a.start == 3 && a.end == 10);

  auto b = section(12, 14), c = section(10, 15), d = section(8, 16);
  assert(!overlaped(a, b)); assert(!mergeable(a, b));
  assert(!overlaped(a, c)); assert(mergeable(a, c));
  assert(overlaped(a, d)); assert(mergeable(a, d));
  auto e = section(4, 8), f = section(2, 15);
  assert(overlaped(a, e)); assert(mergeable(a, e));
  assert(overlaped(a, f)); assert(mergeable(a, f));
  auto g = section(1, 5), h = section(-1, 3), i = section(-5, 0);
  assert(overlaped(a, g)); assert(mergeable(a, g));
  assert(!overlaped(a, h)); assert(mergeable(a, h));
  assert(!overlaped(a, i)); assert(!mergeable(a, i));

  assert(merge(a, c) == section(3, 15));
  assert(merge(a, d) == section(3, 16));
  assert(merge(a, e) == section(3, 10));
  assert(merge(a, f) == section(2, 15));
  assert(merge(a, g) == section(1, 10));
  assert(merge(a, h) == section(-1, 10));
}
