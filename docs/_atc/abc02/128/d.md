---
title: "ABC #128 D"
problem: https://atcoder.jp/contests/abc128/tasks/abc128_d
---
途中に宝石を $$ D $$ に詰める操作が入るのは意味がないので, 左から $$ a $$ 個, 右から $$ b $$ 個宝石を取り, 価値が負が宝石をできるだけ戻すのが最適である.

これをすべての $$ a, b $$ で全探索する.
