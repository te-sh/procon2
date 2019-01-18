---
title: "ARC #045 B"
problem: https://atcoder.jp/contests/arc045/tasks/arc045_b
---
教室ごとに掃除する人数を計算する. imos 法を使えば高速に計算できる.

あとは区間ごとにその区間の掃除する人数の最小値が2以上になっていることを確認する. これは Sparce Table に掃除する人数を入れておけば高速に確認できる.
