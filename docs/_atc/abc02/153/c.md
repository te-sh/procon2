---
title: "ABC #153 C"
problem: https://atcoder.jp/contests/abc153/tasks/abc153_c
---
すべてのモンスターは必殺技だけで倒すか攻撃だけで倒すかのどちらかである.

$$ N \leq K $$ ならばすべて必殺技で倒せる. そうでなければ $$ H_i $$ を昇順にソートして最初の $$ K $$ 体は必殺技で倒して, 残りは攻撃で倒すのが最適である.
