---
title: "ABC #104 C"
problem: https://atcoder.jp/contests/abc104/tasks/abc104_c
---
点数はすべて $$ 1/100 $$ して考える.

$$ i $$ 番目の問題まで見たときに $$ j $$ 点を取るための最小の問題数を $$ A(i, j) $$ とすると,

$$
A(i, j) = \min(A(i-1, j), A(i-1, j-i)+1, A(i-1, j-2i)+2, \dots, A(i-1,j-(p_i-1)i)+p_i-1, A(i-1,j-(p_ii+c_i))+p_i)
$$

という漸化式をたてることができる. これを DP で計算して $$ G $$ より大きい点数を取るための最小の問題数を求める.
