---
title: "ABC #103 D"
problem: https://atcoder.jp/contests/abc103/tasks/abc103_d
---
要望は $$ b_i $$ で昇順にソートする.

要望を最初から見ていき, 次の操作を行う.

* 今の要望が満たされているときは何もしない. 今の要望が満たされている条件は, 最後に落とした橋を $$ x $$ とすると, $$ a_i \geq x $$ である.

* 今の要望が満たされていないときは $$ b_i-1 $$ の橋を落とす.
