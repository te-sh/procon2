---
title: "ABC #172 E"
problem: https://atcoder.jp/contests/abc172/tasks/abc172_e
---
$$ A $$ を決めたときの $$ B $$ の個数はすべて同じとなる. よって, $$ A = \{ 1, 2, \dots, N \} $$ として $$ B_i \leq i $$ となる $$ B $$ の個数を考える.

$$ C_i $$ を $$ B_i = i $$ となる事象とすると, 求める個数は

$$
\perm{M}{N} - \abs{C_1 \cup C_2 \cup \cdots C_N}
$$

となる. よって, 包除の定理を使って,

$$
\perm{M}{N} - \sum_{i=1}^N \perm{M-i}{N-i} \cdot \combi{N}{i} (-1)^{i-1}
$$

となる. これにすべての $$ A $$ の組み合わせ $$ \perm{M}{N} $$ を掛けたものが答えとなる.

階乗とその逆数はあらかじめ計算しておく.
