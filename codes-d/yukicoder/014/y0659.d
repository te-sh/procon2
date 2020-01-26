// URL: https://yukicoder.me/problems/no/659

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int R, C, T; io.getV(R, C, T);
  int Sx, Sy; io.getV(Sx, Sy);
  int Gx, Gy; io.getV(Gx, Gy);
  string[] B; io.getC(R, B);

  auto n = (R-2)*(C-2), a = Matrix!double(n, n);
  auto idx(int i, int j) { return (i-1)*(C-2)+(j-1); }

  foreach (i; 1..R-1)
    foreach (j; 1..C-1) {
      if (B[i][j] == '#') continue;
      auto d = [B[i-1][j], B[i+1][j], B[i][j-1], B[i][j+1]].map!(bij => bij == '.' ? 1 : 0).sum;
      auto id1 = idx(i, j);
      if (d == 0) {
        a[id1][id1] = 1;
      } else {
        if (B[i-1][j] == '.') a[idx(i-1, j)][id1] = 1.0/d;
        if (B[i+1][j] == '.') a[idx(i+1, j)][id1] = 1.0/d;
        if (B[i][j-1] == '.') a[idx(i, j-1)][id1] = 1.0/d;
        if (B[i][j+1] == '.') a[idx(i, j+1)][id1] = 1.0/d;
      }
    }

  auto v = Vector!double(n);
  v[idx(Sx, Sy)] = 1;

  auto p = a^^T * v;
  io.put(p[idx(Gx, Gy)]);
}

import lib.math.matrix;

auto io = IO!()();
import lib.io;
