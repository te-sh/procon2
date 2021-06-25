---
title: "ABC #142 D"
problem: https://atcoder.jp/contests/abc142/tasks/abc142_d
---
棒の長さの短い順にソートする. ここから $$ i, j, k \ (i \lt j \lt k) $$ 本目の棒を選び出すことを考える.

$$ i, j $$ を固定したとき, $$ c \gt a - b, c \gt b - a, c \lt a+b $$ となるように $$ k $$ を選ぶ. 最初の 2 つは $$ i \lt j \lt k $$ の前提から無条件で成り立つ. よって, 3 つ目の条件を満たす $$ k $$ の個数を二分探索で求める.

これをすべての $$ i, j $$ について計算し, 合計を求める.
