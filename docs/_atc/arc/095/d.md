---
title: "ARC #095 D"
problem: https://atcoder.jp/contests/abc094/tasks/arc095_b
---
$$ a_i \gt a_j \gt a_k $$ となる数を選んだとき, $$ {\rm comb}(a_i, a_k) \gt {\rm comb}(a_j, a_k) $$ であるので, $$ {\rm comb}(n, r) $$ の $$ n $$ は $$ \{ a_i \} $$ の最大値を選ぶのが最適である.

また, $$ r $$ はできるだけ $$ n/2 $$ に近い数を選ぶのが最適である.
