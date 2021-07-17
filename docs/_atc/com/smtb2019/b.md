---
title: "SMTB2010 B"
problem: https://atcoder.jp/contests/sumitrust2019/tasks/sumitb2019_b
---
本体価格を $$ X $$ とすると,

$$
\floor{ \frac{108X}{100} } = N
$$

となるので,

$$
N \leq \frac{108X}{100} \lt N+1
$$

となる. これを解いて,

$$
\frac{100N}{108} \leq X \lt \frac{100(N+1)}{108}
$$

となる. $$ X $$ は整数であるから, $$ X $$ がとりうる最小値は

$$
X_m = \ceil{ \frac{100N}{108} }
$$

である. よって,

$$
\floor{ \frac{108X_m}{100} } = N
$$

となるなら $$ X_m $$ を, そうでなければ `:(` を出力する.
