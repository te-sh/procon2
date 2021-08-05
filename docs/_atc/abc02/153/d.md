---
title: "ABC #153 D"
problem: https://atcoder.jp/contests/abc153/tasks/abc153_d
---
体力が $$ x $$ のモンスター $$ 1 $$ 匹がいるときに勝つまでに行う攻撃回数を $$ f(x) $$ とすると,

$$
f(x) = 2f(\floor{x/2}) + 1
$$

である.

これを再帰で計算する.
