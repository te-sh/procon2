---
title: "ARC #064 D"
problem: https://beta.atcoder.jp/contests/abc048/tasks/arc064_b
---
先頭と末尾の文字が同じ場合:

負けになるパターンは `ababab...ba` だけである. よって, $$ \vert s \vert $$ が偶数の場合は先手の勝ち, そうでなければ後手の勝ちである.

先頭と末尾の文字が違う場合:

負けになるパターンは `ababa...ab` だけである.  よって, $$ \vert s \vert $$ が奇数の場合は先手の勝ち, そうでなければ後手の勝ちである.
