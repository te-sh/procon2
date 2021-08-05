---
title: "ABC #154 E"
problem: https://atcoder.jp/contests/abc154/tasks/abc154_e
---
桁 DP を使う.

最大値かどうか, $$ 0 $$ 以外の数字がいくつ使われているか (ただし $$ K+1 $$ 以上はひとつの状態にまとめる) をキーとし, そのような数がいくつあるかを値として桁 DP で計算する.
