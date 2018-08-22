---
title: "ABC #105 D"
problem: https://beta.atcoder.jp/contests/abc105/tasks/abc105_c
---
$$ [l, r) $$ の区間で $$ S = A_l + A_{l+1} + \dots + A_{r-1} $$ が $$ M $$ の倍数になるとする. すなわち, $$ S \equiv 0 \bmod M $$ である.

このとき, $$ [0, i) $$ の累積和を $$ C_i $$ とすると, $$ S = C_r - C_l $$ であるので, $$ C_r \equiv C_l \bmod M $$ となる.

よって, $$ l $$ を決めると, 条件を満たす $$ r $$ の数は, $$ r \in [l+1, N) $$ において $$ C_r \equiv C_l \bmod M $$ となる $$ r $$ の数となる.

これを解くには $$ C_r $$ を $$ M $$ で割った余りが $$ k $$ になる数を連想配列で持っておき, $$ l $$ を後ろから連想配列を更新しながら動かして数を数えればいい.
