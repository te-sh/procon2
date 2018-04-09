---
title: "ARC #094 C"
problem: https://beta.atcoder.jp/contests/arc094/tasks/arc094_a
---
$$ a, b, c $$ から始めてすべての数字が揃うまでの操作の回数を $$ F(a, b, c) $$ とすると,

$$
F(a, b, c) = \min(F(a+1, b+1, c), F(a+1, b, c+1), F(a, b+1, c+1), F(a+2, b, c), F(a, b+2, c), F(a, b, c+2)) + 1
$$

となる. ただし, $$ F(a, a, a) = 0 $$ である.

$$ a, b, c $$ は60以内に収まるだろうから, これを超えた場合は $$ F(a, b, c) = \infty $$ としておく.

これをメモ化再帰で計算する.
