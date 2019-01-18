---
title: "ARC #083 D"
problem: https://atcoder.jp/contests/abc074/tasks/arc083_b
---
完全グラフからどれだけ道を取り除けるかを考える.

Floyd-Warshal 法の計算を改造する. Floyd-Warshal 法の計算は,

$$
D_{ij} = \min(D_{ij}, D_{ik}+D_{jk})
$$

である.

この問題ではすでに最短距離が与えられているので, $$ D_{ij} \gt D_{ik}+D_{kj} $$ となることはありえない. したがって, このような場合は `-1` である.

また, $$ D_{ij} = D_{ik}+D_{kj}\ (i \neq k, j \neq k) $$ となるときは, $$ i, j $$ を直結する道は取り除いても最短距離は変わらないので取り除く.
