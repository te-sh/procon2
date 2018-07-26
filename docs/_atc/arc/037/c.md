---
title: "ARC #037 C"
problem: https://beta.atcoder.jp/contests/arc037/tasks/arc037_c
---
上から $$ K $$ 番目が $$ x $$ とすると, $$ a_ib_j \leq x $$ となる $$ i, j $$ は $$ K $$ 個以上あるはずで, このような数で最小の値が答えとなる.

$$ a_ib_j \leq x $$ の数を数えるには, $$ a_i $$ を固定して $$ b_j \leq \lfloor x/a_i \rfloor $$ となる $$ b_j $$ の数を数える方法を使う. これは $$ b_j $$ をソートしておけば二分探索で求められる.

これで $$ x $$ についても二分探索を行う.
