---
title: "ABC #099 C"
problem: https://beta.atcoder.jp/contests/abc099/tasks/abc099_c
---
使えるお金は $$ 1 $$ 円, $$ 6 $$ 円, $$ 6^2 $$ 円,... $$ 6^7 $$ 円, $$ 9 $$ 円, $$ 9^2 $$ 円,... $$ 9^6 $$ 円の14種類なので, DP で解く.

$$ 1 $$ 円および $$ 6^k $$ 円は5回まで, $$ 9^k $$ 円は8回までしか使わないと考えていい. これより多く使う場合はより上位の金額を使った方が回数が少なくなるためである.

貪欲でも解けるらしいが, chokudai 氏が「貪欲は結構思いつくのが難しいので何も考えずに DP でいいんじゃないか」と発言していた.