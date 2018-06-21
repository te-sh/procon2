---
title: "ARC #053 B"
problem: https://beta.atcoder.jp/contests/arc053/tasks/arc053_b
---
文字の出現数を数える. 出現数が偶数のものは適当に並べられるが, 奇数のものは別々の回文にするしかない. よって, 最小の回文数は出現数が奇数の文字の数である. これを $$ a $$ とする.

残りは適当に並べていいので, $$ \lfloor (\vert S \vert - a)/2a \rfloor \times 2 + 1 $$ が答えになる.

なお, $$ a = 0 $$ のときは分割の必要はないので $$ \vert S \vert $$ になる.
