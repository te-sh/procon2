---
title: "ABC #113 D"
problem: https://atcoder.jp/contests/abc113/tasks/abc113_d
---
ある高さにおいてあり得る横棒の組み合わせをすべて求めておく.

後は DP で解く. 高さ $$ a $$ において $$ b $$ 番目の列に到達する組み合わせの数を $$ C(a, b) $$ とする.

このとき, 先に求めた横棒の組み合わせを見ていき, $$ C(a+1, b-1) $$ に遷移できる横棒の組み合わせならば $$ C(a+1, b-1) $$ に $$ C(a, b) $$ の値を加える.