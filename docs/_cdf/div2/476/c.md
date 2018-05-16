---
title: "Div.2 #476 C"
problem: http://codeforces.com/contest/965/problem/C
---
Arkady が $$ d $$ 回受け取るとする. このとき, $$ x $$ は以下のようになる.

$$
(d-1)k+1 \leq \left\lfloor \frac{n}{x} \right\rfloor \leq dk
$$

このときに Arkady がもらえる飴の数は $$ dx $$ となるので, $$ x $$ はなるべく大きい方がいい. よって,

$$
(d-1)k+1 \leq \left\lfloor \frac{n}{x} \right\rfloor
$$

の部分だけ見ればいい. これが成り立つ最大の $$ x $$ は二分探索で求めることができる.
