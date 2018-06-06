---
title: "ARC #065 D"
problem: https://beta.atcoder.jp/contests/abc049/tasks/arc065_c
---
道路と鉄道を別々に Union-Find で連結部分を管理したとき, ある都市 $$ i, j $$ については道路の Union-Find で所属する森が同じかつ鉄道の Union-Find で所属する森が同じ場合に, 鉄道でも道路でも連結していることになる.

ある都市 $$ i $$ の道路, 鉄道の森番号を組で持ちソートしておけば, 二分探索で同じ森番号の組を探すことができる.
