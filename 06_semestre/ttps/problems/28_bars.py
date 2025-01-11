"""
[vjudge.net/problem/UVA-12455](https://vjudge.net/problem/UVA-12455)

Some things grow if you put them together.

We have some metallic bars, theirs length known, and, if necessary, we want to
solder some of them in order to obtain another one being exactly a given length
long. No bar can be cut up. Is it possible?

Input
The first line of the input contains an integer t, 0 ≤ t ≤ 50, indicating the
number of test cases. For each test case, three lines appear, the first one
contains a number n, 0 ≤ n ≤ 1000, representing the length of the bar we want to
obtain. The second line contains a number p, 1 ≤ p ≤ 20, representing the number
of bars we have. The third line of each test case contains p numbers,
representing the length of the p bars.

Output
For each test case the output should contain a single line, consists of the
string 'YES' or the string 'NO', depending on whether solution is possible or
not.

Sample Input
4
25
4
10 12 5 7
925
10
45 15 120 500 235 58 6 12 175 70
120
5
25 25 25 25 25
0
2
13 567

Sample Output
NO
YES
NO
YES
**ENDS IN NEW LINE**
"""

import sys
import typing as t


def sum_up_to(seq: t.Sequence[int], k: int) -> int:
    N = len(seq) + 1
    K = k + 1

    prev = [0] * K
    curr = [0] * K

    for i in range(1, N):
        actual = seq[i - 1]
        for j in range(1, K):
            pv = prev[j]

            if actual > j:
                curr[j] = pv
                continue

            new = prev[(j - actual)] + actual
            curr[j] = pv if pv > new else new

        if curr[K - 1] == k:
            return k

        prev, curr = curr, prev

    return prev[K - 1]


words = sys.stdin.read().split()
word_i = 1
cases = int(words[0])
r = ""
while cases > 0:
    cases -= 1

    desire_len = int(words[word_i + 0])
    bars_len = int(words[word_i + 1])
    bars = tuple(int(words[i]) for i in range(word_i + 2, word_i + 2 + bars_len))
    word_i += 2 + bars_len

    nearest_sum = sum_up_to(bars, desire_len)
    if nearest_sum == desire_len:
        r += "YES\n"
    else:
        r += "NO\n"

sys.stdout.write(r)
