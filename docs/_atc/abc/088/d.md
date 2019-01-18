---
title: "ABC #088 D"
problem: https://atcoder.jp/contests/abc088/tasks/abc088_d
---
けぬす君が通るマス以外はすべて黒に変えられる. すなわち, スタートからゴールまでの最短距離を $$ d $$, 最初の黒マスの数を $$ b $$ とすると, 得られる最大得点は $$ HW - (d+1) - b $$ である.

スタートからゴールまでの最短距離の取得には dijkstra 法を使った.
