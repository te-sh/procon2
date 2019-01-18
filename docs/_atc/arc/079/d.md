---
title: "ARC #079 D"
problem: https://atcoder.jp/contests/abc068/tasks/arc079_b
---
最終状態を $$ \{ N-1, N-1, \dots, N-1 \} $$ とする. これを1つずつ戻していく.

$$ \{ 2N-1, N-2, N-2, N-2, \dots, N-2 \} $$

$$ \{ 2N-2, 2N-2, N-3, N-3, \dots, N-3 \} $$

$$ \{ 2N-3, 2N-3, 2N-3, N-4, N-4, \dots, N-4 \} $$

$$ \vdots $$

$$ \{ N, N, \dots, N \} $$

1サイクルが $$ N $$ で, すべての要素が $$ 1 $$ 増えた配列を得る.

よって, $$ m = \lfloor K/N \rfloor $$ 回戻した後の配列は,

$$ \{ N-1+m, N-1+m, \dots, N-1+m \} $$

となり, 残りの回数はシミュレートで戻せばいい.
