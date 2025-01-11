"""
[vjudge.net/problem/UVA-315](https://vjudge.net/problem/UVA-315)

A Telephone Line Company (TLC) is establishing a new telephone cable network.
 They are connecting several places numbered by integers from 1 to N. No two
 places have the same number. The lines are bidirectional and always connect
 together two places and in each place the lines end in a telephone exchange.
 There is one telephone exchange in each place. From each place it is possible
 to reach through lines every other place, however it need not be a direct
 connection, it can go through several exchanges. From time to time the power
 supply fails at a place and then the exchange does not operate. The officials
 from TLC realized that in such a case it can happen that besides the fact that
 the place with the failure is unreachable, this can also cause that some other
 places cannot connect to each other. In such a case we will say the place
 (where the failure occured) is critical. Now the officials are trying to write
 a program for finding the number of all such critical places. Help them.

Input
The input file consists of several blocks of lines. Each block describes one
 network. In the first line of each block there is the number of places N < 100.
 Each of the next at most N lines contains the number of a place followed by the
 numbers of some places to which there is a direct line from this place. These
 at most N lines completely describe the network, i.e., each direct connection
 of two places in the network is contained at least in one row. All numbers in
 one line are separated by one space. Each block ends with a line containing
 just '0'. The last block has only one line with N = 0.

Output
The output contains for each block except the last in the input file one line
 containing the number of critical places.

Sample Input
5
5 1 2 3 4
0
6
2 1 3
5 4 6 2
0
0

Sample Output
1
2
**ENDS NEW LINE**
"""

import sys
import typing as t


def find_cutpoints(g_adj: t.Sequence[t.Sequence[int]]) -> t.Set[int]:
    timer = 0
    n = len(g_adj)
    visited = [False] * n
    tin = [-1] * n
    low = [-1] * n

    cutpoints = t.cast(t.Set[int], set())

    def dfs(v: int, p: int = -1) -> None:
        nonlocal timer, cutpoints
        visited[v] = True
        tin[v] = low[v] = timer
        timer += 1
        children = 0

        for to in g_adj[v]:
            if to == p:
                continue
            if visited[to]:
                low[v] = min(low[v], tin[to])
            else:
                dfs(to, v)
                low[v] = min(low[v], low[to])

                if low[to] >= tin[v] and p != -1:
                    cutpoints.add(v)

                children += 1

        if p == -1 and children > 1:
            cutpoints.add(v)

    for i in range(n):
        if not visited[i]:
            dfs(i)

    return cutpoints


lines = sys.stdin.read().splitlines()
line_i = 1
line = lines[0]
r = ""
while line != "0":
    places = int(line)
    g = t.cast(t.Sequence[t.Set[int]], tuple(set() for _ in range(places)))

    while True:
        line = lines[line_i]
        line_i += 1
        if line == "0":
            break

        place, *n = (int(n) - 1 for n in line.split())
        g[place].update(n)
        for place_i in n:
            g[place_i].add(place)

    critical_places = find_cutpoints(g)  # type: ignore
    r += str(len(critical_places)) + "\n"
    line = lines[line_i]
    line_i += 1

sys.stdout.write(r)
