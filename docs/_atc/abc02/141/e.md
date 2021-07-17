---
title: "ABC #141 E"
problem: https://atcoder.jp/contests/abc141/tasks/abc141_e
---
$$ S $$ の Suffix Array を求め, LCP を計算する.

Suffix Array の $$ i $$ 番目と $$ j $$ 番目の LCP はその間の LCP の最小値を取ればいいので, これを Sparce Table で管理して $$ i, j $$ で全探索する.
