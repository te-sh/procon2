---
title: "Panasonic2020 C"
problem: https://atcoder.jp/contests/panasonic2020/tasks/panasonic2020_c
---
誤差が怖いので整数問題に帰着させる.

$$
\sqrt{a} + \sqrt{b} \lt \sqrt{c}
$$

は両辺正なのでそれぞれ2乗して整理すると

$$
2\sqrt{ab} \lt c - a - b
$$

となる. $$ c - a - b \leq 0 $$ なら "No" である. そうでない場合は両辺は正なのでそれぞれ2乗して

$$
4ab \lt (c - a - b)^2
$$

となる. この式で比較する.
