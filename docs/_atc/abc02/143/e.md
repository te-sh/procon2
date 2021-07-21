---
title: "ABC #142 E"
problem: https://atcoder.jp/contests/abc142/tasks/abc142_e
---
町を頂点とするグラフ $$ G $$ を作成し, $$ A_i $$ と $$ B_i $$ を結ぶ道について長さ $$ C_i $$ の辺を引く. そしてすべての 2 頂点間の最短距離を Floyd-Warshal 法で求める.

次に町を頂点とする新たなグラフ $$ H $$ を作成し, 2 頂点 $$ a, b $$ 間の $$ G $$ 上の最短距離が $$ L $$ 以下の場合, $$ H $$ の $$ a, b $$ 間に長さ $$ 1 $$ の辺を引く.

このとき, $$ s_i $$ から $$ t_i $$ への移動の際の最小給油回数は $$ H $$ 上の $$ s_i, t_i $$ 間の最短距離から $$ 1 $$ を引いたものとなる. $$ H $$ のすべての 2 頂点間の最短距離も Floyd-Warshal 法で求める.