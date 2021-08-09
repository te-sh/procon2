// URL: https://yukicoder.me/problems/no/674

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long D; int Q; io.getV(D, Q);

  auto inf = 2*10L^^18, m = 0L, rbt = redBlackTree!"a.x<b.x"([P(-inf, -inf), P(inf, inf)]);

  foreach (_; 0..Q) {
    long A, B; io.getV(A, B); ++B;
    auto p = P(A, B), pr = rbt.lowerBound(p).back;
    P u;
    if (pr.y < A) {
      u = p;
    } else {
      u = P(pr.x, max(pr.y, B));
      rbt.removeKey(pr);
    }
    P[] rm;
    foreach (po; rbt.upperBound(P(A-1, B))) {
      if (po.x > u.y) break;
      rm ~= po;
      u = P(u.x, max(u.y, po.y));
    }
    foreach (rmi; rm) rbt.removeKey(rmi);
    m = max(m, u.y-u.x);
    rbt.insert(u);
    io.put(m);
  }
}

alias P = Point2!long;
import lib.math.point;

auto io = IO!()();
import lib.io;
