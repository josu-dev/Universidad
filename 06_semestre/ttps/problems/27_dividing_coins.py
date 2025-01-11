"""
[vjudge.net/problem/UVA-562](https://vjudge.net/problem/UVA-562)

It's commonly known that the Dutch have invented copper-wire. Two Dutch men were
fighting over a nickel, which was made of copper. They were both so eager to get
it and the fighting was so fierce, they stretched the coin to great length and
thus created copper-wire.

Not commonly known is that the fighting started, after the two Dutch tried to
divide a bag with coins between the two of them. The contents of the bag
appeared not to be equally divisible. The Dutch of the past couldn't stand the
fact that a division should favour one of them and they always wanted a fair
share to the very last cent. Nowadays fighting over a single cent will not be
seen anymore, but being capable of making an equal division as fair as possible
is something that will remain important forever...

That's what this whole problem is about. Not everyone is capable of seeing
instantly what's the most fair division of a bag of coins between two persons.
Your help is asked to solve this problem.

Given a bag with a maximum of 100 coins, determine the most fair division
between two persons. This means that the difference between the amount each
person obtains should be minimised. The value of a coin varies from 1 cent to
500 cents. It's not allowed to split a single coin.

Input
A line with the number of problems n, followed by n times:
• a line with a non negative integer m (m ≤ 100) indicating the number of coins
in the bag
• a line with m numbers separated by one space, each number indicates the value
of a coin.

Output
The output consists of n lines. Each line contains the minimal positive
difference between the amount the two persons obtain when they divide the coins
from the corresponding bag.

Sample Input
2
3
2 3 5
4
1 2 4 6

Sample Output
0
1
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
word_i = 0
cases = int(words[0])
r = ""
while cases > 0:
    cases -= 1

    coins_len = int(words[word_i + 1])
    coins = tuple(int(words[i]) for i in range(word_i + 2, word_i + 2 + coins_len))

    word_i += 1 + coins_len

    total = sum(coins)

    nearest_sum = sum_up_to(coins, total // 2)
    diff = total - nearest_sum
    r += str(diff - nearest_sum if diff > nearest_sum else nearest_sum - diff) + "\n"

sys.stdout.write(r)
