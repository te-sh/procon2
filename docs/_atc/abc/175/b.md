---
title: "ABC #175 B"
problem: https://atcoder.jp/contests/abc175/tasks/abc175_b
---
題意を満たす $$ L_i, L_j, L_k $$ の条件は,

$$
L_i \neq L_j \\
L_j \neq L_k \\
L_k \neq L_i \\
L_i + L_j \gt L_k \\
L_j + L_k \gt L_i \\
L_k + L_i \gt L_j
$$

である. これを $$ i, j, k $$ で総当りする.
