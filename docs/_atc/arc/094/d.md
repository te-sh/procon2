---
title: "ARC #094 D"
problem: https://atcoder.jp/contests/arc094/tasks/arc094_b
---
$$ A \leq B $$ としても一般性を失わない.

$$ C^2 \lt AB $$ となる最大の $$ C $$ を考える. このとき, 高橋君よりスコアが小さい人は1回目か2回目で $$ C $$ 位以内を取っている. $$ A \leq C \lt B $$ ならば1回目で $$ C-1 $$ 人, 2回目で $$ C $$ 人の人が高橋君より低いスコアを取る可能性があり, 合計で $$ 2C-1 $$ 人に可能性がある.

このとき, 1回目に $$ 1, 2, \dots, A-1 $$ 位, 2回目に $$ A+B-1, A+B-2, B+1 $$ 位を取った人のスコアは

$$
(A-x)(B+x) = AB-(B-A)x-x^2 \lt AB
$$

となる. よって, この $$ A-1 $$ 人は高橋君よりスコアが低い.

また, 1回目に $$ A+1, A+2, \dots, 2C $$ 位, 2回目に $$ 2C-A, 2C-A-1, \dots, 1 $$ 位を取った人のスコアは

$$
x(2C-x+1) = -x^2+(2C+1)x
$$

となる. なお, 相加相乗平均の定理から $$ 2C-A \lt B $$ は保証される. これは $$ x = C, C+1 $$ のときに最大となり, 最大値は $$ C(C+1) $$ である. よって, $$ AB \gt C(C+1) $$ であればこの $$ 2C-A $$ 人は高橋君よりスコアが低い.

よって, $$ AB \gt C(C+1) $$ の条件下では $$ 2C-1 $$ 人が高橋君よりスコアが低くなるため, 上限を達成できる.

次に $$ AB \leq C(C+1) $$ の場合を考える.

この場合は1回目に $$ C $$ 位を取った人は2回目に $$ C $$ 位以下を取らないといけない. よって上限は $$ 2C-2 $$ 人である.

最初の $$ A-1 $$ 人は最初のパターンと同様に考える. さらに1回目に $$ A+1, A+2, \dots, 2C-1 $$ 位, 2回目に $$ 2C-A-1, 2C-A-2, \dots, 1 $$ 位を取った人のスコアは

$$
x(2C-x) = -x^2+2Cx
$$

となる. これは $$ x = C $$ のときに最大となり, 最大値は $$ C^2 $$ である. よって, この $$ 2C-A-1 $$ 人は高橋君よりスコアが低くなる. 合計すると $$ 2C-2 $$ が高橋君よりスコアが低くなり, 上限を達成できる.

最後に $$ A = B $$ の場合を考える.

この場合は高橋君よりスコアが小さい人は1回目か2回目で $$ A-1 $$ 位以内を取っている. よって上限は $$ 2A-2 $$ 人である.

このとき, 1回目に $$ 1, 2, \dots 2A-1 $$ 位, 2回目に $$ 2A-1, 2A-2, \dots, 1 $$ 位を取った人のスコアは

$$
x(2A-x) = -x^2 + 2Ax
$$

となる. これは $$ x = A $$ のときに最大となり, 最大値は $$ A^2 $$ である. $$ A $$ 位は高橋君が取っているので, それ以外の $$ 2A-1 $$ 人は高橋君よりスコアが低くなるため, 上限を達成できる.
