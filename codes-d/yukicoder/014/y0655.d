// URL: https://yukicoder.me/problems/no/655

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, K; long P; io.getV(N, K, P);
  Point[] b; io.getS!("x", "y")(K, b);
  foreach (ref bi; b) { --bi.x; --bi.y; }

  if (N == 1) { io.put(0); return; }

  auto a = kaidan!long(N);
  foreach (ref ai; a) ai[] = -1;

  auto q = DList!Point(b);
  auto dp = [Point(-1, -1), Point(-1, 0), Point(0, -1), Point(0, 1), Point(1, 0), Point(1, 1)];
  foreach (ref bi; b) a[bi.x][bi.y] = 0;
  while (!q.empty) {
    auto pp = q.front; q.removeFront;
    foreach (dpi; dp) {
      auto np = pp + dpi;
      if (np.x < 0 || np.x >= N || np.y < 0 || np.y > np.x || a[np.x][np.y] >= 0) continue;
      a[np.x][np.y] = a[pp.x][pp.y] + 1;
      q.insertBack(np);
    }
  }

  auto as = kaidan!long(N+1);
  foreach_reverse (i; 0..N)
    foreach (j; 0..i+1) {
      as[i][j] = as[i+1][j] + as[i+1][j+1] + a[i][j];
      if (i < N-1) as[i][j] -= as[i+2][j+1];
    }

  auto bs = kaidan2!long(N+1);
  foreach_reverse (i; 0..N)
    foreach (j; 0..i+1)
      bs[i][j+1] = bs[i][j]+bs[i+1][j+1]-bs[i+1][j]+a[i][j];

  auto calc(int i, int j, int e)
  {
    if (e == 0) return a[i][j];
    else return as[i][j]-as[i+e+1][j+e+1]-bs[i+e+1][j+e+1]+bs[i+e+1][j];
  }

  auto e = kaidan!int(N);
  foreach (j; 0..N) e[N-1][j] = as[N-1][j] >= P ? 0 : 1;

  foreach_reverse (i; 0..N-1)
    foreach (j; 0..i+1) {
      auto r = min(e[i+1][j], e[i+1][j+1]);
      while (r >= 0 && calc(i, j, r) >= P) --r;
      e[i][j] = r+1;
    }

  auto ans = 0L;
  foreach (i; 0..N)
    foreach (j; 0..i+1)
      ans += N-(e[i][j]+i);

  io.put(ans);
}

auto kaidan(T)(int n)
{
  auto a = new T[][](n);
  foreach (i; 0..n) a[i] = new T[](i+1);
  return a;
}

auto kaidan2(T)(int n)
{
  auto a = new T[][](n);
  foreach (i; 0..n) a[i] = new T[](i+2);
  return a;
}

alias Point = Point2!int;
import lib.math.point;

auto io = IO!()();
import lib.io;
