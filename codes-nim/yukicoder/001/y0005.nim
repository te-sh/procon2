# URL: https://yukicoder.me/problems/no/5

import algorithm, sequtils, strutils

var l = stdin.readline.parseInt
var n = stdin.readline.parseInt
var w = stdin.readline.split.map(parseInt)

w.sort

var c = 0
for wi in w:
  if l < wi: break
  l -= wi
  c += 1

echo c
