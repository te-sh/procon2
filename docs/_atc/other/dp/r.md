---
title: "Educational DP Contest R"
problem: https://atcoder.jp/contests/dp/tasks/dp_r
---
頂点 $$ u $$ から頂点 $$ v $$ まで長さ $$ k $$ で行ける通り数を $$ C(u, v, k) $$ とする. 当然ながら, $$ C(u, v, 1) = a_{i,j} $$ である.

ここで, $$ C(u, v, k) $$ を考えると,

$$
\sum_w C(u, w, k-1)C(w, v, 1)
$$

となる. これは行列の積の定義そのものである.

よって入力された $$ a_{i,j} $$ を行列とみなしてこれを $$ K $$ 乗 (繰り返し2乗法を使う) し, すべての要素を合計したものが答えとなる.
