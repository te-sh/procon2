---
title: "ARC #069 C"
problem: https://beta.atcoder.jp/contests/abc055/tasks/arc069_a
---
まずは `c` 型ピースを組み合わせて `S` 型ピースを作らないとしていくつ `Scc` が作れるかを考える.

これは $$ x = \min(N, \lfloor M/2 \rfloor) $$ 個である.

この結果, `c` 型ピースは $$ M-2x $$ 個となり, `c` 型ピースだけ使って `Scc` が作れる個数は $$ y = \lfloor (M-2x)/4 \rfloor $$ である.
