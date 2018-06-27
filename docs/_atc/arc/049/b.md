---
title: "ARC #049 B"
problem: https://beta.atcoder.jp/contests/arc049/tasks/arc049_b
---
$$ i $$ 番目の高橋ノルム君は時刻 $$ t $$ には $$ x_i-t/c_i \leq x \leq x_i+t/c_i, y_i-t/c_i \leq y \leq y_i+t/c_i $$ で囲まれる正方形の範囲に移動できる. 任意の2人の高橋ノルム君が移動できる正方形に共通部分があれば, 全員が同じ位置に移動できる.

共通部分があるかどうかは片方の正方形の頂点のうちどれかがもう片方の正方形内に存在するかどうかで確認できる.

あとは $$ t $$ を二分探索で探す.
