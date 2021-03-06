---
title: "ARC #036 C"
problem: https://atcoder.jp/contests/arc036/tasks/arc036_c
---
`1` が現れたら $$ +1 $$, `0` が現れたら $$ -1 $$ として先頭から累積和を取ることを考える. このとき, 各桁の累積和の値の最大と最小の差が $$ K $$ 以内になるようにしなければならない.

$$ i $$ 桁目まで見たときに累積和の最大が $$ j $$, 最小が $$ k $$, 現在値が $$ l $$ となるような組み合わせの数を $$ C(i, j, k, l) $$ として DP で解く方法が考えられるが, この方法だと計算量が $$ O(N^4) $$ で間に合わない.

そこで, $$ i $$ 桁目まで見たときに累積和の最大最小の差が $$ j $$, 累積和の最大と現在値の差が $$ k $$ となるような組み合わせの数を $$ C(i, j, k) $$ とすると, この計算量は $$ O(N^3) $$ となるので, 今度は間に合う.
