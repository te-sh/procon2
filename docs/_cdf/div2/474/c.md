---
title: "Div.2 #474 C"
problem: http://codeforces.com/contest/960/problem/C
---
同じ数値を使ってはいけないとは言っていないので, 使う数値を $$ 1, 1+d, 1+2d, \dots $$ とする. こうすれば違う数値同士は干渉しあわない.

$$ 1 $$ を $$ k_0 $$ 個並べると $$ 2^{k_0}-1 $$ 個の部分列ができ, 最大最小の差は当然すべて $$ 0 $$ なので, $$ x $$ を超えないように $$ k_0 $$ を選ぶ.

同様に $$ k_1 $$ 以降も決めていけば使う数値は高々30個程度なので制限内で収まる.