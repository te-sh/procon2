---
title: "ABC #130 D"
problem: https://atcoder.jp/contests/abc130/tasks/abc130_d
---
累積和をあらかじめ求めておく.

左端 $$ L $$ を決めると, 区間 $$ [L, R] $$ の $$ A_i $$ の和が $$ K $$ 以上になる $$ R $$ の個数は二分探索で求められる.

これをすべての $$ L $$ に対して行い, 合計する.
