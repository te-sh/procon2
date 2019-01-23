---
title: "ABC #115 D"
problem: https://atcoder.jp/contests/abc115/tasks/abc115_d
---
レベル $$ i $$ バーガーの層の数とパティの数をそれぞれ $$ h_i, p_i $$ とする. このとき,

$$
h_{i+1} = 2h_i+3 \\
p_{i+1} = 2p_i+1
$$

となる. この漸化式を用いて $$ h_i, p_i $$ を $$ 0 \leq i \leq N $$ の範囲で求めておく.

さて, レベル $$ i $$ バーガーの下から $$ j $$ 層まで食べたときのパティの数を $$ P(i,j) $$ とする. これは以下のようになる.

$$
P(0, 1) = 1 \\
P(i,j) =
\begin{cases}
0 & j = 1 \\
P(i-1,j-1) & 2 \leq j \leq h_{i-1}+1 \\
p_{i-1}+1 & j = h_{i-1}+2 \\
p_{i-1}+1+P(i-1,j-h_{i-1}-2) & h_{i-1}+3 \leq j \leq 2h_{i-1}+2 \\
2p_{i-1}+1 & j = 2h_{i-1}+3
\end{cases}
$$

あとは再帰で計算する.
