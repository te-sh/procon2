---
title: "Educational DP Contest U"
problem: https://atcoder.jp/contests/dp/tasks/dp_u
---
BitDP を使う.

うさぎの集合 $$ S $$ をグループ分けしたときの相性の合計の最大を $$ C(S) $$ とすると,

$$
C(S) = \max_{T \subset S} (C(T) + C(S \setminus T))
$$

となる.

これをそのまま計算すると $$ O(4^N) $$ となるが, ある集合の部分集合を列挙する部分でうまく工夫すると $$ O(3^N) $$ に落とすことができる.

よって計算量は $$ O(3^N) $$ である.
