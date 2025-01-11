"""
[vjudge.net/problem/UVA-10583](https://vjudge.net/problem/UVA-10583)

There are so many different religions in the world today that it is difficult to
 keep track of them all. You are interested in finding out how many different
 religions students in your university believe in. You know that there are n
 students in your university (0 < n ≤ 50000). It is infeasible for you to ask
 every student their religious beliefs. Furthermore, many students are not
 comfortable expressing their beliefs. One way to avoid these problems is to ask
 m (0 ≤ m ≤ n(n - 1)/2) pairs of students and ask them whether they believe in
 the same religion (e.g. they may know if they both attend the same church).
 From this data, you may not know what each person believes in, but you can get
 an idea of the upper bound of how many different religions can be possibly
 represented on campus. You may assume that each student subscribes to at most
 one religion.

Input
The input consists of a number of cases. Each case starts with a line specifying
 the integers n and m. The next m lines each consists of two integers i and j,
 specifying that students i and j believe in the same religion. The students are
 numbered 1 to n. The end of input is specified by a line in which n = m = 0.

Output
For each test case, print on a single line the case number (starting with 1)
 followed by the maximum number of different religions that the students in the
 university believe in.

Sample Input
10 9
1 2
1 3
1 4
1 5
1 6
1 7
1 8
1 9
1 10
10 4
2 3
4 5
4 8
5 8
0 0

Sample Output
Case 1: 1
Case 2: 7
**ENDS NEW LINE**
"""

import sys
import typing as t


class UFDS:
    def __init__(self, size: int = 0):
        self.p = [i for i in range(size)]
        self.rank = [0] * size

    def find_set(self, i: int) -> int:
        parent = self.p[i]
        if i == parent:
            return i

        parent = self.p[i] = self.find_set(parent)
        return parent

    def union_set(self, i: int, j: int) -> None:
        x = self.find_set(i)
        y = self.find_set(j)
        if x == y:
            return

        if self.rank[x] > self.rank[y]:
            self.p[y] = x
            return

        self.p[x] = y
        if self.rank[x] == self.rank[y]:
            self.rank[y] = y + 1

    def count_sets(self) -> int:
        return sum(1 for i in range(len(self.p)) if self.p[i] == i)

    def reset(self, size: t.Optional[int] = None) -> None:
        size = size if size else len(self.p)
        self.p = [i for i in range(size)]
        self.rank = [0] * size


lines = sys.stdin.read().split()
line_i = 0
size = len(lines)
test_case = 0
ufds = UFDS()
r = ""

while lines[line_i] != "0":
    test_case += 1
    n = int(lines[line_i])
    m = int(lines[line_i + 1])
    line_i += 2

    ufds.reset(n)

    for i in range(line_i, line_i + m * 2, 2):
        s1 = int(lines[i]) - 1
        s2 = int(lines[i + 1]) - 1
        ufds.union_set(s1, s2)
    line_i += m * 2

    r += "Case " + str(test_case) + ": " + str(ufds.count_sets()) + "\n"

sys.stdout.write(r)
