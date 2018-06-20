---
title: "ARC #054 C"
problem: https://beta.atcoder.jp/contests/arc054/tasks/arc054_c
---
木の置換の一つを $$ \sigma $$ とすると, $$ i $$ 番目のタイヤは $$ \sigma(i) $$ 番目の木とペアになる. このペアがすべて相性がいいということは,

$$
S_{1\sigma(1)}S_{2\sigma(2)} \cdots S_{N\sigma(N)} = 1
$$

となることと同義である. よってその個数は,

$$
\sum_{\sigma} S_{1\sigma(1)}S_{2\sigma(2)} \cdots S_{N\sigma(N)}
$$

となる.

これは行列式の定義と似ている. 行列式の定義は

$$
\sum_{\sigma} sgn(\sigma) S_{1\sigma(1)}S_{2\sigma(2)} \cdots S_{N\sigma(N)}
$$

である. 求めるのは偶奇なので, $$ \bmod 2 $$ の値であるが, $$ sgn(\sigma) $$ は $$ \pm 1 $$ であり, これはともに $$ \bmod 2 $$ では $$ 1 $$ となるので, 個数と行列式の値の偶奇は一致する.

よって, $$ S $$ の行列式の値の偶奇を見ればいい.
