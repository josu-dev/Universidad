"""
[vjudge.net/problem/UVA-10131](https://vjudge.net/problem/UVA-10131)

Some people think that the bigger an elephant is, the smarter it is. To disprove
 this, you want to take the data on a collection of elephants and put as large a
 subset of this data as possible into a sequence so that the weights are
 increasing, but the IQ's are decreasing.

Input
The input will consist of data for a bunch of elephants, one elephant per line,
 terminated by the endof-file. The data for a particular elephant will consist
 of a pair of integers: the first representing its size in kilograms and the
 second representing its IQ in hundredths of IQ points. Both integers are
 between 1 and 10000. The data will contain information for at most 1000
 elephants. Two elephants may have the same weight, the same IQ, or even the
 same weight and IQ.

Output
Say that the numbers on the i-th data line are W[i] and S[i]. Your program
 should output a sequence of lines of data; the first line should contain a
 number n; the remaining n lines should each contain a single positive integer
 (each one representing an elephant). If these n integers are a[1], a[2], ...,
 a[n] then it must be the case that

    W[a[1]] < W[a[2]] < ... < W[a[n]]

 and

    S[a[1]] > S[a[2]] > ... > S[a[n]]

In order for the answer to be correct, n should be as large as possible. All
 inequalities are strict: weights must be strictly increasing, and IQs must be
 strictly decreasing.
There may be many correct outputs for a given input, your program only needs to
 find one.

Sample Input
6008 1300
6000 2100
500 2000
1000 4000
1100 3000
6000 2000
8000 1400
6000 1200
2000 1900

Sample Output
4
4
5
9
7
**ENDS IN NEW LINE**
"""

# LO HIZO CHATGPT, no me dio
import sys
import typing as t


def sorted_idxs(elfs: t.List[t.Tuple[int, int, int]]):
    # Sort by decreasing IQ and for same IQ, sort by increasing weight
    # elfs.sort(key=lambda x: (-x[2], x[1]))
    elfs.sort(key=lambda x: ((x[2] ^ ~0) << 14) | x[1])

    size = len(elfs)
    dp = [1] * size
    parent = [-1] * size

    i_max = 0
    # f =lambda x: print("{:<14}".format(bin((((x[2]^ ~0) << 15) ^1<<14) | x[1]).split('b')[1].zfill(29)))
    for i in range(size):
        # f(elfs[i])
        for j in range(i):
            if elfs[i][1] > elfs[j][1] and dp[i] < dp[j] + 1:
                dp[i] = tmp = dp[j] + 1
                if tmp > dp[i_max]:
                    i_max = i
                parent[i] = j

    i = i_max
    sequence = t.cast(t.List[int], [])
    while i != -1:
        sequence.append(elfs[i][0])
        i = parent[i]

    sequence.reverse()
    return sequence


lines = sys.stdin.read().split()
i = 0
size = len(lines)
elfs = t.cast(t.List[t.Tuple[int, int, int]], list())
while i < size:
    elfs.append((i // 2, int(lines[i]), int(lines[i + 1])))
    i += 2

idxs = sorted_idxs(elfs)
r = (
    str(len(idxs))
    + "\n"
    + "\n".join(str(i + 1) for i in idxs)
    + "\n"
)
sys.stdout.write(r)
