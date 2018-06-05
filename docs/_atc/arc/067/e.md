---
title: "ARC #067 E"
problem: https://beta.atcoder.jp/contests/arc067/tasks/arc067_c
---
最低 $$ x $$ 人のグループを作るという条件の元で $$ n $$ 人をグループ分けする組み合わせの数を $$ f(n, x) $$ とする.

当然ながら, 以下のようになる.

$$
x \gt B \rightarrow f(n, x) = 0 \\
n \lt xC \rightarrow f(n, x) = 0
$$

$$ n $$ 人いるときに $$ x $$ 人のグループを $$ k $$ 個作るときの組み合わせの数は

$$
g(n, x, k) = \frac{n!}{(x!)^k(n-kx)!} \frac{1}{k!} f(n-kx, x+1)
$$

で表せるので,

$$
f(n, x) = \sum_{k=C}^D g(n, x, k) + f(n, x+1)
$$

となる. これをメモ化再帰で計算する.

階乗と逆元はあらかじめ計算しておく.
