# URL: https://yukicoder.me/problems/no/4

import math, sequtils, strutils

var
  n = stdin.readline.parseInt
  w = stdin.readline.split.map(parseInt)
  ws = w.sum

if ws mod 2 == 1:
  echo "impossible"
  quit 0
ws = ws div 2

var dp = newSeqWith(n+1, newSeq[bool](ws+1))
dp[0][0] = true

for i in 0..<n:
  for j in 0..ws:
    dp[i+1][j] = dp[i][j]
    if j >= w[i]:
      dp[i+1][j] = dp[i+1][j] or dp[i][j-w[i]]

echo if dp[n][ws]: "possible" else: "impossible"
