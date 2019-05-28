---
title: "ABC #117 D"
problem: https://atcoder.jp/contests/abc118/tasks/abc117_d
---
ビットごとに考える. そこで, 桁 DP を使う.

何ビット目まで見たか, 最大値かどうかをキーにして, $$ f(X) $$ の最大値を値にとる bit DP を行う.
