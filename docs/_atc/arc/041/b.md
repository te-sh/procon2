---
title: "ARC #041 B"
problem: https://beta.atcoder.jp/contests/arc041/tasks/arc041_b
---
端にアメーバがいなかったので, $$ b(1,j) = a(2,j) $$ である.

また, $$ b(2,j) = a(2,j-1)+a(2,j+1)+a(1,j)+a(3,j) $$ であり, $$ a(1,*), a(2,*) $$ は決まっているので, $$ a(3,j) $$ も決まる.

以下芋づる式に $$ a $$ は決められる.
