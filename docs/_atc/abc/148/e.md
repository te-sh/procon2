---
title: "ABC #148 E"
problem: https://atcoder.jp/contests/abc148/tasks/abc148_e
---
$$ n $$ が奇数のときは $$ f(n) = 1 \cdot 3 \cdot 5 \cdots n $$, $$ n $$ が偶数のときは $$ f(n) = 1 \cdot 2 \cdot 4 \cdots n $$ となる.

$$ n $$ が奇数のときは積の素因数に $$ 2 $$ がないので, 末尾の $$ 0 $$ の数は $$ 0 $$ 個である.

$$ n $$ が偶数のときは $$ 1 \cdot 2 \cdot 3 \cdots n/2 $$ に素因数 $$ 5 $$ が何個入っているかを数える.
