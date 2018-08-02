---
title: "ARC #043 B"
problem: https://beta.atcoder.jp/contests/arc043/tasks/arc043_b
---
$$ D_i $$ はソートしておく.

$$ i $$ 問目に $$ j $$ 番目の問題を選ぶ組み合わせの数は,

$$
C(i, j) = \sum_{k=1}^m C(i-1, k)
$$

と表せる. $$ m $$ は $$ j $$ 番目の問題難易度の半分以下の難易度で一番難易度が高い問題である.

$$ m $$ は二分探索を使えば求めることができる. 和の部分は累積和を計算しておけばいい.