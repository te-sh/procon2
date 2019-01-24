---
title: "Educational DP Contest F"
problem: https://atcoder.jp/contests/dp/tasks/dp_f
---
$$ s $$ の $$ i $$ 文字目と $$ t $$ の $$ j $$ 文字目まで見たときの最長一致部分列の最大値を $$ A(i, j) $$ とすると,

$$ s_i = t_j $$ のとき:

$$
A(i, j) = \max(A(i-1, j), A(i, j-1), A(i-1, j-1)+1)
$$

$$ s_i \neq t_j $$ のとき:

$$
A(i, j) = \max(A(i-1, j), A(i, j-1))
$$

となる.

これで最大値を求めた後, その文字列を復元する. $$ A(\vert s \vert, \vert t \vert) $$ からスタートして, $$ A(0, 0) $$ までたどり着くルートを考える.

$$ A(i, j) $$ にいるとき,

* $$ A(i-1, j) = A(i, j) $$ ならば移動できる.
* $$ A(i, j-1) = A(i, j) $$ ならば移動できる.
* $$ A(i-1, j-1) = A(i, j)-1 $$ ならば移動できる. このとき, $$ s_i(=t_j) $$ の文字は部分列の要素である.

という感じで部分列の要素を拾っていけば部分列を再生できる.

計算量は $$ O(\vert s \vert \vert t \vert) $$ である.
