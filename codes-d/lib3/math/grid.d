import point;

struct Grid(T)
{
  import std.algorithm;
  alias G = Grid!T, P = Point2!int;
  size_t r, c;
  T[][] data;

  this(size_t r, size_t c) { this.r = r; this.c = c; data = new T[][](r, c); }
  this(T[][] data) { this.data = data; r = data.length; c = data[0].length; }

  pure T opIndex(size_t x, size_t y) { return data[y][x]; }
  pure T opIndex(P p) { return data[p.y][p.x]; }
  G opIndexAssign(T v, size_t x, size_t y) { data[y][x] = v; return this; }
  G opIndexAssign(T v, P p) { data[p.y][p.x] = v; return this; }
  G opIndexOpAssign(string op)(T v, size_t x, size_t y) { mixin("data[y][x]"~op~"=v;"); return this; }
  G opIndexOpAssign(string op)(T v, P p) { mixin("data[p.y][p.x]"~op~"=v;"); return this; }

  pure bool valid(size_t x, size_t y) { return 0 <= x && x < c && 0 <= y && y < r; }
  pure bool valid(P p) { return valid(p.x, p.y); }
  auto d4 = [P(-1, 0), P(0, -1), P(1, 0), P(0, 1)];
  pure auto around4(P p) { return d4.map!(d => d+p).filter!(np => valid(np)); }
  auto d8 = [P(-1, 0), P(-1, -1), P(0, -1), P(1, -1), P(1, 0), P(1, 1), P(0, 1), P(-1, 1)];
  pure auto around8(P p) { return d8.map!(d => d+p).filter!(np => valid(np)); }
}

unittest
{
  import std.algorithm;

  auto a = Grid!int([[1, 2], [3, 4]]);
  alias P = a.P;

  assert(a[1, 0] == 2);
  assert(a[P(0, 1)] == 3);

  a[1, 0] = 5;
  assert(a[1, 0] == 5);
  a[P(0, 1)] = 6;
  assert(a[0, 1] == 6);

  a[1, 0] += 2;
  assert(a[1, 0] == 7);
  a[P(0, 1)] -= 3;
  assert(a[0, 1] == 3);

  assert(a.valid(1, 0));
  assert(!a.valid(2, 0));
  assert(a.valid(P(0, 1)));
  assert(!a.valid(P(0, 2)));

  assert(equal(a.around4(P(0, 0)), [P(1, 0), P(0, 1)]));
  assert(equal(a.around8(P(1, 1)), [P(0, 1), P(0, 0), P(1, 0)]));
}
