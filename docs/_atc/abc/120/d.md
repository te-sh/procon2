---
title: "ABC #120 D"
problem: https://atcoder.jp/contests/abc120/tasks/abc120_d
---
時系列を逆に考える.

橋が1本もかかってない時点の不便さは $$ N(N-1)/2 $$ である.

ここから時系列を逆にして1本ずつ橋をかけていく. これを Union-Find で管理する.

橋を1本かけたとき, その両端が同じ森に所属する場合は不便さは減らない.

そうでない場合は, その両端が所属する森に所属する島の数をそれぞれ $$ a, b $$ とすると, $$ ab $$ だけ不便さが減る.