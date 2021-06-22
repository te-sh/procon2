---
title: "ABC #139 D"
problem: https://atcoder.jp/contests/abc139/tasks/abc139_d
---
$$ M_i $$ の取りうる最大値は $$ P_i-1 $$ である.

$$ \{ P_1, P_2, \ldots, P_{N-1}, P_N \} = \{ 2, 3, \dots, N, 1 \} $$ とすればすべての $$ M_i $$ は取りうる最大値になるので, 合計も最大値となる.

よって, $$ \sum_{k=1}^{N-1} k = N(N-1)/2 $$ が答えである.
