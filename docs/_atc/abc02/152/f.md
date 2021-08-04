---
title: "ABC #152 F"
problem: https://atcoder.jp/contests/abc152/tasks/abc152_f
---
木は根付き木とする.

$$ u_i $$ と $$ v_i $$ の間のパスに使う辺番号のビット列を求める. これは $$ u_i $$ から根までのパスに使う辺番号のビット列と $$ v_i $$ から根までのパスに使う辺番号のビット列の XOR を取れば求まる.

さて, 求める事象 "$$ u_i $$ と $$ v_i $$ の間のパスに使う辺の中に黒が1つ以上含まれる" を $$ A_i $$ として $$ \abs{A_1 \cap A_2 \cap \cdots \cap A_M} $$ を求めるのであるが, そのまま求めるのは難しいので余事象を考える.

すなわち $$ \abs{\overline{A_1} \cup \overline{A_2} \cup \cdots \cup \overline{A_M}} $$ を求めるのだが, これには包除の原理が使える.

$$ B_i $$ を $$ \{ \overline{A_1}, \overline{A_2}, \dots, \overline{A_M} \} $$ の部分集合とすると, $$ \cap B_i $$ が成り立つには $$ A_j $$ に含まれる辺番号のビット列の OR を取ったビット列の `popcount` した数の辺は白固定で残りは何でもいいので, $$ 2^k $$ で簡単に求まる.
