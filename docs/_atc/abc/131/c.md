---
title: "ABC #131 C"
problem: https://atcoder.jp/contests/abc131/tasks/abc131_c
---
$$ n $$ 以下の数のうち, $$ C $$ か $$ D $$ で割り切れるものの個数 $$ N(n) $$ は, 包除の定理を用いて,

$$
 \lfloor n/C \rfloor + \lfloor n/D \rfloor - \lfloor n/LCM(C, D) \rfloor
$$

となる.

よって, $$ A $$ 以上 $$ B $$ 以下の数の中で $$ C $$ でも $$ D $$ でも割り切れないものの個数は,

$$
B-A+1-(N(B)-N(A-1))
$$

となる.
