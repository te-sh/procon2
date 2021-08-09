// URL: https://yukicoder.me/problems/no/675

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, Px, Py; io.getV(N, Px, Py);
  auto c = new Matrix!int[](N);
  foreach (i; 0..N) {
    int ct; io.getV(ct);
    switch (ct) {
    case 1:
      int dx; io.getV(dx);
      c[i] = matrix([[1, 0, dx], [0, 1, 0], [0, 0, 1]]);
      break;
    case 2:
      int dy; io.getV(dy);
      c[i] = matrix([[1, 0, 0], [0, 1, dy], [0, 0, 1]]);
      break;
    case 3:
      c[i] = matrix([[0, 1, 0], [-1, 0, 0], [0, 0, 1]]);
      break;
    default:
      assert(0);
    }
  }

  auto m = Matrix!int.unit(3), x = new int[](N), y = new int[](N);
  foreach_reverse (i; 0..N) {
    m *= c[i];
    x[i] = m[0][0]*Px + m[0][1]*Py + m[0][2];
    y[i] = m[1][0]*Px + m[1][1]*Py + m[1][2];
  }

  foreach (xi, yi; lockstep(x, y)) io.put(xi, yi);
}

import lib.math.matrix;

auto io = IO!()();
import lib.io;
