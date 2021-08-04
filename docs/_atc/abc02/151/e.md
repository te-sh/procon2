---
title: "ABC #151 E"
problem: https://atcoder.jp/contests/abc151/tasks/abc151_e
---
$$ S $$ は全通り考えるので $$ A_i $$ はソートしておいても答えは変わらない. よって, 昇順にソートしておく.

$$ \max $$ と $$ \min $$ は分けて考えられる.

$$ i $$ 番目の要素が $$ \min S $$ となる $$ S $$ の個数は, $$ i $$ より右側の要素から $$ K-1 $$ 個選ぶ組み合わせの数なので, $$ \combi{N-i}{K-1} $$ である. よって, $$ \min S $$ の合計は

$$
\sum_{i=1}^N A_i \cdot \combi{N-i}{K-1}
$$

となる. $$ \max $$ も同様に考える.
