---
title: "ARC #055 C"
problem: https://beta.atcoder.jp/contests/arc055/tasks/arc055_c
---
$$ ABC $$ と $$ AC $$ の切れ目で全探索する.

$$ S $$ を $$ T_1, T_2 $$ に分割したとき, $$ T_1 $$ と $$ T_2 $$ の最長一致 prefix と最長一致 suffix を $$ a, b $$ とする.

このとき, $$ a+b \lt \vert T_2 \vert $$ ならば $$ AC $$ が作れないので組み合わせの数は $$ 0 $$ である.

$$ a+b \geq \vert T_2 \vert $$ ならば $$ a+b- \vert T_2 \vert +1 $$ 個の組み合わせが作れる.

$$ a $$ は Suffix Array と LCP Array を作っておいて LCP Array を Sparse Table に入れておけば $$ O(1) $$ で求められる. $$ b $$ は $$ S $$ を反転させて Suffix Array を作れば後は同様である.
