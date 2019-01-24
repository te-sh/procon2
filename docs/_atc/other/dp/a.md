---
title: "Educational DP Contest A"
problem: https://atcoder.jp/contests/dp/tasks/dp_a
---
足場 $$ i $$ にたどり着く最小コストを $$ C(i) $$ とすると,

$$
C(i) = \min(C(i-1) + \vert h_i - h_{i-1} \vert, C(i-2) + \vert h_i - h_{i-2} \vert)
$$

となる. これを $$ i=1 $$ から順に計算する.

計算量は $$ O(N) $$ である.
