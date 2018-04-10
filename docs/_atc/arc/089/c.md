---
title: "ARC #089 C"
problem: https://beta.atcoder.jp/contests/abc086/tasks/arc089_a
---
$$ x_0 = y_0 = t_0 = 0 $$ とする.

時刻 $$ t_i $$ に $$ (x_i, y_i) $$ を訪れることが可能な条件は, 以下の通りである.

* $$ \vert x_i - x_{i-1} \vert + \vert y_i - y_{i-1} \vert \leq t_i-t_{i-1} $$ が成立する.
* $$ x_i+y_i $$ と $$ t_i $$ の偶奇が一致する.
