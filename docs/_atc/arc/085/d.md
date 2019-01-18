---
title: "ARC #085 D"
problem: https://atcoder.jp/contests/abc078/tasks/arc085_b
---
$$ N = 1 $$ のときはスコアは $$ \vert a_N-W \vert $$ である.

$$ N \geq 2 $$ のときは, Xさんは次の2通りのどちらかを選択する.

* カードをすべて取る. スコアは $$ \vert a_N-W \vert $$ である.
* カードを1枚残して取る. スコアは $$ \vert a_{N-1}-a_N \vert $$ である.

カードを2枚以上残す意味はない. なぜなら, 2枚以上残してもYさんが残り1枚残して取ることでスコアを $$ \vert a_{N-1}-a_N \vert $$ にすることができ, これより高いスコアにはならないからである.
