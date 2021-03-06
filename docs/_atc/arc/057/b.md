---
title: "ARC #057 B"
problem: https://atcoder.jp/contests/arc057/tasks/arc057_b
---
コツとしてはなるべく勝率を上げないことである. 機嫌がいい日は前日までの成績より少しだけ上回るように勝てばいいし, 機嫌がよくない日は全敗でいい.

そこで, $$ i $$ 日終わって $$ j $$ 回機嫌が良かったときの累積勝数の最小値を $$ C(i, j) $$ とする. また $$ i $$ 日目までの試合数の合計を $$ S(i) $$ とする. このとき, $$ C(i, j) $$ の遷移は以下のようになる.

まず, $$ C(i, j) $$ が与えられたとき, 次で最低何勝しないと最終的に $$ K $$ 勝にならないかという下限 $$ b $$ と次で何勝すれば機嫌よくなれるかを求める $$ c $$ を求める.

$$
b = max(0, K - \sum_{k=i+1}^{N} a_i - C(i, j)) \\
c = \left\lfloor \frac{C(i, j)a_{i+1}}{S(i+1)} \right\rfloor + 1
$$

$$ c \gt a_{i+1} $$ ならば全勝してもだめなので,

$$
C(i, j)+a_{i+1} \rightarrow C(i+1, j)
$$

である. そうでないならば,

$$
C(i, j)+\max(b, c) \rightarrow C(i+1, j+1) \\
C(i, j)+\max(0, b) \rightarrow C(i+1, j)
$$

となる.
