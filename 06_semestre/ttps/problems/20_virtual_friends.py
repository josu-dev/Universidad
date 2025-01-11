"""
[vjudge.net/problem/UVA-11503](https://vjudge.net/problem/UVA-11503)

These days, you can do all sorts of things online. For example, you can use
 various websites to make virtual friends. For some people, growing their social
 network (their friends, their friends' friends, their friends' friends'
 friends, and so on), has become an addictive hobby. Just as some people collect
 stamps, other people collect virtual friends. Your task is to observe the
 interactions on such a website and keep track of the size of each person's
 network. Assume that every friendship is mutual. If Fred is Barney's friend,
 then Barney is also Fred's friend.

Input
The first line of input contains one integer specifying the number of test cases
 to follow. Each test case begins with a line containing an integer F, the
 number of friendships formed, which is no more than 100 000. Each of the
 following F lines contains the names of two people who have just become
 friends, separated by a space. A name is a string of 1 to 20 letters (uppercase
 or lowercase).

Output
Whenever a friendship is formed, print a line containing one integer, the number
 of people in the social network of the two people who have just become friends.

Sample Input
1
3
Fred Barney
Barney Betty
Betty Wilma

Sample Output
2
3
4
**ENDS NEW LINE**
"""

import sys
import typing as t


class UFDS:
    def __init__(self, size: int = 0):
        self.p = [i for i in range(size)]
        self.rank = [0] * size
        self.sizes = [1] * size

    def find_set(self, i: int) -> int:
        parent = self.p[i]
        if i == parent:
            return i

        parent = self.p[i] = self.find_set(parent)
        return parent

    def union_set(self, i: int, j: int) -> int:
        x = self.find_set(i)
        y = self.find_set(j)
        if x == y:
            return x

        if self.rank[x] > self.rank[y]:
            self.p[y] = x

            self.sizes[x] = self.sizes[x] + self.sizes[y]
            return x

        self.p[x] = y
        if self.rank[x] == self.rank[y]:
            self.rank[y] = y + 1

        self.sizes[y] = self.sizes[x] + self.sizes[y]
        return y

    def reset(self, size: t.Optional[int] = None) -> None:
        size = size if size else len(self.p)
        self.p = [i for i in range(size)]
        self.rank = [0] * size
        self.sizes = [1] * size


lines = sys.stdin.read().split()
line_i = 1
test_case = int(lines[0])
ufds = UFDS()
name_to_i = t.cast(t.Dict[str, int], {})
r = ""
while test_case > 0:
    n = int(lines[line_i]) * 2
    line_i += 1
    names = 0
    name_to_i.clear()
    ufds.reset(n)

    for i in range(line_i, line_i + n, 2):
        n1 = name_to_i.get(lines[i], names)
        if n1 is names:
            name_to_i[lines[i]] = names
            names += 1
        n2 = name_to_i.get(lines[i + 1], names)
        if n2 is names:
            name_to_i[lines[i + 1]] = names
            names += 1

        size = ufds.sizes[ufds.union_set(n1, n2)]
        r += str(size) + "\n"

    line_i += n
    test_case -= 1

sys.stdout.write(r)
