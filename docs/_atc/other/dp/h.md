---
title: "Educational DP Contest H"
problem: https://atcoder.jp/contests/dp/tasks/dp_h
---
マス $$ (i, j) $$ にたどり着く組み合わせの数を $$ C(i, j) $$ とすると, そのマスが空きマスならば

$$
C(i, j) = C(i-1, j)+C(i, j-1)
$$

となる.

計算量は $$ O(HW) $$ である.
