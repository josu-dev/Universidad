"""
[vjudge.net/problem/UVA-459](https://vjudge.net/problem/UVA-459)

Consider a graph G formed from a large number of nodes connected by edges. G is
 said to be connected if a path can be found in 0 or more steps between any pair
 of nodes in G. For example, the graph below is not connected because there is
 no path from A to C.

This graph contains, however, a number of subgraphs that are connected, one for
 each of the following sets of nodes: {A}, {B}, {C}, {D}, {E}, {A,B}, {B,D},
 {C,E}, {A,B,D}

A connected subgraph is maximal if there are no nodes and edges in the original
 graph that could be added to the subgraph and still leave it connected. There
 are two maximal connected subgraphs above, one associated with the nodes {A, B,
 D} and the other with the nodes {C, E}.

Write a program to determine the number of maximal connected subgraphs of a
 given graph.

Input
The input begins with a single positive integer on a line by itself indicating
 the number of the cases following, each of them as described below. This line
 is followed by a blank line, and there is also a blank line between two
 consecutive inputs.

The first line of each input set contains a single uppercase alphabetic
 character. This character represents the largest node name in the graph. Each
 successive line contains a pair of uppercase alphabetic characters denoting an
 edge in the graph.

The sample input section contains a possible input set for the graph pictured
 above. Input is terminated by a blank line.

Output
For each test case, write in the output the number of maximal connected
 subgraphs. The outputs of two consecutive cases will be separated by a blank
 line.

Sample Input
1

E
AB
CE
DB
EC

Sample Output
2
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

    def count_sets(self) -> int:
        return sum(1 for i in range(len(self.p)) if self.p[i] == i)


lines = sys.stdin.read().split("\n")
line_i = 1
lines_len = len(lines)
cases = int(lines[0])
ufds = UFDS()
r = ""

while cases > 0:
    line_i += 1
    nodes = ord(lines[line_i]) - 64
    line_i += 1

    ufds.reset(nodes)

    line = lines[line_i]
    while line:
        e1 = ord(line[0]) - 65
        e2 = ord(line[1]) - 65
        ufds.union_set(e1, e2)
        line_i += 1
        line = lines[line_i] if line_i < lines_len else ""

    r += str(ufds.count_sets()) + "\n\n"
    cases -= 1

sys.stdout.write(r[:-1])
