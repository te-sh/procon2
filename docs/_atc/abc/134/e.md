---
title: "ABC #134 E"
problem: https://atcoder.jp/contests/abc134/tasks/abc134_e
---
後ろから見ていく.

まず, 一番後ろの色は適当に塗るしかない.

$$ A_i $$ を塗るときであるが, 今まで塗った色について, 色 $$ c $$ の最小値 (一番先頭よりの数値) を $$ B_c $$ とすると, $$ A_i < B_c $$ となる $$ B_c $$ のうち一番小さい $$ B_c $$ の色に塗るのが最適である.

これは赤黒木を使えば $$ O(N\log N) $$ で実現できる.
