---
title: "ABC #064 D"
problem: https://atcoder.jp/contests/abc064/tasks/abc064_d
---
辞書順最小なので, 先頭に `(` を必要なだけ追加して, 末尾に `)` を追加するのが最適である.

いくつ追加するかであるが, `(` を +1, `)` を -1 として累積和をとり, 最小値を $$ m $$, 最後の値を $$ c $$ とする.

このとき, 先頭には $$ -m $$ 個の `(` を追加すればよく, 末尾には $$ c-m $$ 個の `)` を追加すればいい.
