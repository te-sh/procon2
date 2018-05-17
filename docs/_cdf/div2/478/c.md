---
title: "Div.2 #478 C"
problem: http://codeforces.com/contest/975/problem/C
---
ダメージが $$ t $$ 貯まると, $$ \sum a_i \leq t $$ である兵士は倒れる.

よって, 累積和を取っておき, 二分探索で残りの兵士数を求めることができる.
