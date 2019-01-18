---
title: "ARC #035 C"
problem: https://atcoder.jp/contests/arc035/tasks/arc035_c
---
まずは Floyd Warshal 法で任意の2点間の距離を計算しておく.

次に $$ X, Y $$ 間に $$ Z $$ の長さの道を追加したとき, $$ D(i, j) $$ がどうなるかを考えると, これは

$$
D(i, j) = \min(D(i, j), D(i, X) + Z + D(Y, j), D(i, Y) + Z + D(X, j))
$$

となる. 計算量は前処理 $$ O(N^3) $$, クエリごとの処理が $$ O(N^2) $$ なので, 合わせて $$ O((N+K)N^2) $$ となる.
