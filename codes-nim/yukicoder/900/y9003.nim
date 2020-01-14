# URL: https://yukicoder.me/problems/no/9003

import strformat, strutils

var n = stdin.readline.parseFloat

echo "decimal"
echo fmt"{n+0.0001:.6f}"
