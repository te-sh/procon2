---
title: "ARC #096 C"
problem: https://beta.atcoder.jp/contests/abc095/tasks/arc096_a
---
ABピザを買う枚数 $$ c $$ を決めれば, Aピザを買う枚数は $$ a = \max(0, X-c/2) $$, Bピザを買う枚数は $$ b = \max(0, Y-c/2) $$ と決まる.

これを $$ 0 \leq c \leq 2\max(X,Y) $$ の範囲で全探索する.
