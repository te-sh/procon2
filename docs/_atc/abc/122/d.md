---
title: "ABC #122 D"
problem: https://atcoder.jp/contests/abc122/tasks/abc122_d
---
4文字からなる文字列をすべて列挙して, 条件を満たすかどうかをあらかじめ計算しておく.

$$ i $$ 文字目まで見たときに後ろ3文字が $$ j $$ である条件を満たす文字列の数を $$ C(i, j) $$ として, DP でこれを更新していく.
