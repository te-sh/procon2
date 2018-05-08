---
title: "Div.2 #474 B"
problem: http://codeforces.com/contest/960/problem/B
---
$$ \vert a_i - b_i \vert $$ が大きいものから差を詰めるように操作すればいい.

$$ \vert a_i - b_i \vert $$ を優先順位付きキューに入れておき, 一番大きい数字をデクリメントする. (0 ならインクリメントする)

最後にキュー内の数値をすべて2乗して足し合わせる.
