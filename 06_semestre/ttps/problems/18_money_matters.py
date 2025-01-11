"""
[vjudge.net/problem/UVA-11690](https://vjudge.net/problem/UVA-11690)

Our sad tale begins with a tight clique of friends. Together they went on a trip
 to the picturesque country of Molvania. During their stay, various events which
 are too horrible to mention occurred. The net result was that the last evening
 of the trip ended with a momentous exchange of “I never want to see you again!
 ”s. A quick calculation tells you it may have been said almost 50 million
 times! Back home in Scandinavia, our group of ex-friends realize that they
 haven't split the costs incurred during the trip evenly. Some people may be out
 several thousand crowns. Settling the debts turns out to be a bit more
 problematic than it ought to be, as many in the group no longer wish to speak
 to one another, and even less to give each other money. Naturally, you want to
 help out, so you ask each person to tell you how much money she owes or is
 owed, and whom she is still friends with. Given this information, you're sure
 you can figure out if it's possible for everyone to get even, and with money
 only being given between persons who are still friends.

Input
The first line of the input file contains an integer N (N ≤ 20) which denotes
 the total number of test cases. The description of each test case is given
 below:

 The first line contains two integers, n (2 ≤ n ≤ 10000), and m (0 ≤ m ≤ 50000),
  the number of friends and the number of remaining friendships. Then n lines
  follow, each containing an integer o (-10000 ≤ o ≤ 10000) indicating how much
  each person owes (or is owed if o < 0). The sum of these values is zero. After
  this comes m lines giving the remaining friendships, each line containing two
  integers x, y (0 ≤ x < y ≤ n - 1) indicating that persons x and y are still
  friends

Output
For each test case your output should consist of a single line saying
 'POSSIBLE' or 'IMPOSSIBLE'.

Sample Input
2
5 3
100
-75
-25
-42
42
0 1
1 2
3 4
4 2
15
20
-10
-25
0 2
1 3

Sample Output
POSSIBLE
IMPOSSIBLE
**ENDS NEW LINE**
"""

import sys


class UFDS:
    def __init__(self, size: int):
        self.p = [i for i in range(size)]
        self.rank = [0] * size

    def find_set(self, i: int) -> int:
        parent = self.p[i]
        if i == parent:
            return i

        parent = self.p[i] = self.find_set(parent)
        return parent

    def same_set(self, i: int, j: int) -> bool:
        return i == j or self.find_set(i) == self.find_set(j)

    def union_set(self, i: int, j: int) -> None:
        if self.same_set(i, j):
            return

        x = self.find_set(i)
        y = self.find_set(j)
        if self.rank[x] > self.rank[y]:
            self.p[y] = x
        else:
            self.p[x] = y
            if self.rank[x] == self.rank[y]:
                self.rank[y] = y + 1


lines = sys.stdin.read().split()
line_i = 1
test_cases = int(lines[0])
r = ""
while test_cases > 0:
    friends = int(lines[line_i])
    friendships = int(lines[line_i + 1])
    line_i += 2

    balances = tuple(int(lines[i]) for i in range(line_i, line_i + friends))
    line_i += friends

    ufds = UFDS(friends)

    for i in range(line_i, line_i + friendships * 2, 2):
        fx = int(lines[i])
        fy = int(lines[i + 1])
        ufds.union_set(fx, fy)
    line_i += friendships * 2

    acc = [0] * friends
    for i in range(friends):
        root = ufds.find_set(i)
        acc[root] += balances[i]

    for total in acc:
        if total != 0:
            r += "IMPOSSIBLE\n"
            break
    else:
        r += "POSSIBLE\n"

    test_cases -= 1

sys.stdout.write(r)
