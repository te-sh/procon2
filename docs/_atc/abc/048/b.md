---
title: "ABC #048 B"
problem: https://beta.atcoder.jp/contests/abc048/tasks/abc048_b
---
$$ f(n) $$ を $$ n $$ 未満の非負整数で $$ x $$ 割り切れる数の個数とすると, $$ f(n) = \lfloor (n-1)/x \rfloor+1 $$ となる. ただし, $$ f(0) = 0 $$ である.

このとき, 答えは $$ f(b+1) - f(a) $$ である.
