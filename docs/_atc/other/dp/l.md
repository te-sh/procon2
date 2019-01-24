---
title: "Educational DP Contest L"
problem: https://atcoder.jp/contests/dp/tasks/dp_l
---
残りの数列の最初と最後がそれぞれ $$ a_i, a_j $$ であるときの最適行動の結果の $$ X-Y $$ を $$ S(i,j) $$ とする. $$ S(i, i) $$ は $$ N $$ が奇数ならば $$ a_i $$, $$ N $$ が偶数ならば $$ -a_i $$ である.

$$ S(i, j) $$ であるが, 太郎君の手番であるとき ($$ N-(j-i+1) $$ が偶数であるとき) は

$$
S(i, j) = \max(a_i+S(i+1, j), a_j+S(i, j-1))
$$

となる. 次郎くんの手番であるときは,

$$
S(i, j) = \min(-a_i+S(i+1, j), -a_j+S(i, j-1))
$$

となる.

計算量は $$ O(N^2) $$ である.
