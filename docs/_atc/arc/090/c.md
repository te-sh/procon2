---
title: "ARC #090 C"
problem: https://beta.atcoder.jp/contests/abc087/tasks/arc090_a
---
下には1回しか移動できないので, その列を $$ k $$ とすると, 回収できる飴の数は,

$$
\sum_{j=1}^k A_{1,j} + \sum_{j=k}^N A_{2,j}
$$

となる. これをすべての $$ k $$ で計算して最大値を求める.
