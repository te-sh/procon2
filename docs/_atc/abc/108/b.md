---
title: "ABC #108 B"
problem: https://beta.atcoder.jp/contests/abc108/tasks/abc108_b
---
$$ A(x_1, y_1) $$ として, 反時計周りに $$ B, C, D $$ とする. $$ A $$ が原点になるように平行移動しておく.

まずは $$ \overrightarrow{AB} $$ と直交するベクトルは $$ t(-x_2, y_2) $$ と表すことができ, 大きさを $$ \overrightarrow{AB} $$ と等しくするためには $$ t = \pm 1 $$ でなければならない. そしてこの値は $$ \overrightarrow{AD} $$ となる.

反時計周りに $$ A, B, C, D $$ が並ぶためには, $$ \overrightarrow{AB} \times \overrightarrow{AD} $$ が正になればいいので, こうなるように $$ t $$ を選ぶ.

$$ \overright{AC} $$ は $$ \overrightarrow{AB} + \overrightarrow{AD} $$ で直ちに求まる.
