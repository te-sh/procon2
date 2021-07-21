---
title: "ABC #124 D"
problem: https://atcoder.jp/contests/abc124/tasks/abc124_d
---
連続している直立している人を最大限反転させるのが最適である.

連続している逆立ちしている人の人数と連続している直立している人数を並べて配列にする. (一番左の人が直立しているならば, 0 を先頭に足して先頭は逆立ちしている人の人数にする. 末尾も同様)

このとき, 並ばせることができる逆立ちしている人数は, 区間 $$ [l, l+2K] $$ の和の最大値である. ただし, $$ l $$ は奇数である.

これは累積和を計算しておけば高速に計算できる.