---
title: "ARC #060 C"
problem: https://beta.atcoder.jp/contests/abc044/tasks/arc060_a
---
$$ i $$ 枚目までのカードを見たときに $$ j $$ 枚のカードを選んだ結果, その合計が $$ k $$ になる組み合わせの数を $$ C(i, j, k) $$ とする. このとき,

$$
C(i, j, k) = C(i-1, j, k) + C(i-1, j-1, k-x_i)
$$

となる. これを DP で計算し, $$ C(N, k, kA) $$ の合計が答えとなる.
