---
title: "ABC #174 B"
problem: https://atcoder.jp/contests/abc174/tasks/abc174_b
---
距離が $$ D $$ 以下の点の数を数える.

$$ \sqrt{X_i^2 + Y_i^2} \leq D $$ という判断式では小数が出てきてしまうので, 両辺を2乗した $$ X_i^2 + Y_i^2 \leq D^2 $$ を使う.

値が `int` の範囲を超える可能性があるので `long` を使う.
