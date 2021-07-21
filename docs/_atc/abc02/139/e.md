---
title: "ABC #139 E"
problem: https://atcoder.jp/contests/abc139/tasks/abc139_e
---
各試合を頂点とするグラフを考える. 試合 $$ x $$ と $$ y $$ について, $$ y $$ が $$ x $$ の後に行わなければならない場合に $$ x $$ から $$ y $$ に有向辺を引く.

グラフが閉路を持つ場合, 試合を組むことができない. そうでない場合, すべての 2 頂点の最長の長さの最大値 + 1 が答えとなる.

閉路の検出と 2 頂点間の長さを算出する順番はトポロジカルソートを使うと便利である.