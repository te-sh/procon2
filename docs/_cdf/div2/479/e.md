---
title: "Div.3 #479 E"
problem: http://codeforces.com/contest/977/problem/E
---
サイクルになっているグラフはすべての頂点の次数が2であるので, Union-Find で連結成分を計算した後, 連結成分ごとに次数を調べる.
