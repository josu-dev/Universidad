"""
[vjudge.net/problem/UVA-10664](https://vjudge.net/problem/UVA-10664)

Peter and his friends are on holiday, so they have decided to make a trip by car
to know the north of Spain. They are seven people and they think that two cars
are enough for their luggage.

It's time to leave ... and a heap of suitcases are awaiting out of the cars.
The drivers disagree about which suitcase must be put into each boot, because
nobody wants one boot to carry more weight than the other one. Is it possible
that the two boots load with the same weight? (Obviously without unpacking the
suitcases!)

Consider m sets of numbers representing suitcases weights, you must decide for
each one, if it is possible to distribute the suitcases into the boots, and the
two boots weigh the same.

Input
The first line of the input contains an integer, m, indicating the number of
test cases.

For each test case, there is a line containing n integers (1 ≤ n ≤ 20) separated
by single spaces. These integers are the weights of each suitcase. The total sum
of the weights of all the suitcases is less or equal to 200 kilograms.

Output
The output consists of m lines. The i-th line corresponds with the i-th set of
suitcases weight and contains the string 'YES' or 'NO', depending on the
possibility that the two boots load with the same weight for the respective test
case.

Sample Input
3
1 2 1 2 1
2 3 4 1 2 5 10 50 3 50
3 5 2 7 1 7 5 2 8 9 1 25 15 8 3 1 38 45 8 1

Sample Output
NO
YES
YES
**ENDS IN NEW LINE**
"""

import sys
import typing as t


def sum_up_to(seq: t.Sequence[int], k: int) -> int:
    N = len(seq) + 1
    K = k + 1
    cache = [0 for _ in range(N * K)]

    for i in range(1, N):
        row_i = i * K
        for j in range(1, K):
            prev = cache[row_i - K + j]

            if seq[i - 1] > j:
                cache[row_i + j] = prev
                continue

            new = cache[row_i - K + (j - seq[i - 1])] + seq[i - 1]
            cache[row_i + j] = prev if prev > new else new

    return cache[N * K - 1]


lines = sys.stdin.readlines()
line_i = 0
lines_len = int(lines[0])
r = ""
while lines_len > 0:
    lines_len -= 1
    line_i += 1
    weights = tuple(int(w) for w in lines[line_i].split())

    total_w = sum(weights)
    if total_w % 2 > 0:
        r += "NO\n"
        continue

    target = total_w // 2
    nearest_sum = sum_up_to(weights, target)
    if nearest_sum == target:
        r += "YES\n"
    else:
        r += "NO\n"

sys.stdout.write(r)
