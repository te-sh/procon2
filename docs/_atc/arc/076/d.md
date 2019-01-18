---
title: "ARC #076 D"
problem: https://atcoder.jp/contests/abc065/tasks/arc076_b
---
最小全域木を作る問題に帰着できる.

このとき, $$ x $$ 座標で昇順に並べたときに, $$ x_i \leftrightarrow x_{i+1} $$ の道しか考えなくてもいい. なぜなら, $$ x_i \leftrightarrow x_{i+2} $$ の道は $$ x_i \leftrightarrow x_{i+1} $$ の道と $$ x_{i+1} \leftrightarrow x_{i+2} $$ の道でカバーできるからである.

$$ y $$ 座標についても同様に考える.

最小全域木を作る方法で, 道をコストの昇順に並べ, Union-Find でコストの小さい順につないでいく.
