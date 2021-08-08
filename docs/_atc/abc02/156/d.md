---
title: "ABC #156 D"
problem: https://atcoder.jp/contests/abc156/tasks/abc156_d
---
まず $$ a, b $$ を考えないで作ることができる花束の数は $$ 2^n - 1 $$ 種類である.

次に $$ a $$ 本の花からなる花束の種類の数は,

$$
\combi{n}{a} = \frac{n(n-1)(n-2)\cdots(n-a+1)}{a(a-1)(a-2)\cdots 1}
$$

となる. これを愚直に計算してすべての種類から引く. $$ b $$ についても同様である.
