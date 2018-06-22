---
title: "ARC #051 A"
problem: https://beta.atcoder.jp/contests/arc051/tasks/arc051_a
---
面倒なので $$ (x_1, y_1) $$ が原点になるように移動しておく.

赤く塗られた部分が残る条件は四角形にすっぽり覆われないことなので, $$ x_2 \gt -r \lor x_3 \lt r \lor y_2 \gt -r \lor y_3 \lt r $$ である.

青く塗られた部分が残る条件は円にすっぽり覆われないことなので, $$ D(x_2, y_2) \gt r \lor D(x_2, y_3) \gt r \lor D(x_3, y_2) \gt r \lor D(x_3, y_3) \gt r $$ である. ただし, $$ D(x, y) = \sqrt{x^2+y^2} $$ である.
