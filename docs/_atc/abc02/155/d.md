---
title: "ABC #155 D"
problem: https://atcoder.jp/contests/abc155/tasks/abc155_d
---
$$ \{ A_i \} $$ は昇順にソートしておく.

答えが $$ X $$ とすると, $$ X $$ は $$ A_iA_j \leq X $$ となる $$ (i, j) $$ の個数 $$ C $$ が $$ C \geq K $$ となる最小の数である. これを二分探索で求める.

$$ C $$ の求め方であるが, $$ i $$ を固定し, $$ A_iA_j \leq X $$ となる $$ j $$ の個数を二分探索で求める. $$ A_i $$ の符号によって $$ A_iA_j $$ が昇順になるか降順になるかが変わるのでそこを注意する. これをすべての $$ i $$ について計算して $$ C $$ を求める.
