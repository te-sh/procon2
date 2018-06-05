---
title: "ARC #068 C"
problem: https://beta.atcoder.jp/contests/abc053/tasks/arc068_a
---
6,5,6,5... と獲得するのが最適である.

よって, まずは $$ 2\lfloor x/11 \rfloor $$ 回操作する. そして $$ x $$ を11で割った余りを求める.

余りが0ならばさらなる操作は必要ない.

余りが6以下ならもう1回操作が必要である.

そうでなければもう2回操作が必要である.
