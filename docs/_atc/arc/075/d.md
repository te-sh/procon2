---
title: "ARC #075 D"
problem: https://beta.atcoder.jp/contests/abc063/tasks/arc075_b
---
$$ x $$ 回の爆発で全滅させられるかを考える.

$$ x $$ 回爆発させると, 各魔物の体力は $$ h_i-xB $$ となる. 残った魔物を倒すには, $$ \lceil (h_i-xB)/(A-B) \rceil $$ 回だけ直撃を与える必要がある. この合計が $$ x $$ 以下ならば $$ x $$ 回の爆発で全滅させることができる.

あとは二分探索である.
