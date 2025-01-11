"""
[vjudge.net/problem/SPOJ-EDIST](https://vjudge.net/problem/SPOJ-EDIST)
[www.spoj.com/submit/EDIST/](https://www.spoj.com/submit/EDIST/)

You are given two strings, A and B. Answer, what is the smallest number of
 operations you need to transform A to B?

Operations are:
1. Delete one letter from one of strings
2. Insert one letter into one of strings
3. Replace one of letters from one of strings with another letter

Input
T - number of test cases

For each test case:
. String A
. String B

Both strings will contain only uppercase characters and they won't be longer
 than 2000 characters.

There will be 10 test cases in data set.

Output
For each test case, one line, minimum number of operations.

Example
Input
1
FOOD
MONEY

Output
4
**ENDS IN NEW LINE**
"""

import sys
import typing as t


def edit_distance(seq1: t.Sequence[t.Any], seq2: t.Sequence[t.Any]) -> int:
    m = len(seq1)
    n = len(seq2)
    if m == 0 or n == 0:
        return m + n

    prev = 0
    curr = list(range(n + 1))

    for i in range(m):
        prev = curr[0]
        curr[0] = i + 1
        to_cmp = seq1[i]
        for j in range(n):
            delete = curr[j + 1]
            temp = curr[j]
            prev += -1 if to_cmp == seq2[j] else 0
            curr[j + 1] = 1 + (
                delete
                if delete < temp and delete < prev
                else (temp if temp < prev else prev)
            )
            prev = delete

    return curr[n]


lines = sys.stdin.read().split()
r = []  # type: list[str] # type: ignore
for i in range(1, int(lines[0]) * 2 + 1, 2):
    seq1 = lines[i]
    seq2 = lines[i + 1]
    d = edit_distance(seq1, seq2)
    r.append("%d\n" % d)

sys.stdout.writelines(r)
