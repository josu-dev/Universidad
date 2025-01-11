"""
[vjudge.net/problem/UVA-796](https://vjudge.net/problem/UVA-796)

In a computer network a link L, which interconnects two servers, is considered
 critical if there are at least two servers A and B such that all network
 interconnection paths between A and B pass through L. Removing a critical link
 generates two disjoint sub-networks such that any two servers of a sub-network
 are interconnected. For example, the network shown in figure 1 has three
 critical links that are marked bold: 0 -1, 3 - 4 and 6 - 7.

Figure 1: Critical links

It is known that:
 1. the connection links are bi-directional;
 2. a server is not directly connected to itself;
 3. two servers are interconnected if they are directly connected or if they are
  interconnected with the same server;
 4. the network can have stand-alone sub-networks.

Write a program that finds all critical links of a given computer network.

Input
The program reads sets of data from a text file. Each data set specifies the
 structure of a network and has the format:

 no_of_servers
 server_0 (no_of_direct_connections) connected_server ... connected_server
 ...
 server_no_of_servers (no_of_direct_connections) connected_server ... connected_server

The first line contains a positive integer no of servers(possibly 0) which is
 the number of network servers. The next no of servers lines, one for each
 server in the network, are randomly ordered and show the way servers are
 connected. The line corresponding to serverk, 0 ≤ k ≤ no of servers - 1,
 specifies the number of direct connections of serverk and the servers which are
 directly connected to serverk. Servers are represented by integers from 0 to no
 of servers - 1. Input data are correct. The first data set from sample input
 below corresponds to the network in figure 1, while the second data set
 specifies an empty network.

Output
The result of the program is on standard output. For each data set the program
 prints the number of critical links and the critical links, one link per line,
 starting from the beginning of the line, as shown in the sample output below.
 The links are listed in ascending order according to their first element. The
 output for the data set is followed by an empty line.

Sample Input
8
0 (1) 1
1 (3) 2 0 3
2 (2) 1 3
3 (3) 1 2 4
4 (1) 3
7 (1) 6
6 (1) 7
5 (0)

0

Sample Output
3 critical links
0 - 1
3 - 4
6 - 7

0 critical links
**ENDS IN 2 NEW LINES**
"""

import sys


def critical_links(
    v: int,
    adjs: "list[list[int]]",
    visited: "list[bool]",
    lap: int,
    parent: "list[int]",
    reachable_on: "list[int]",
    discover_on: "list[int]",
    criticals: "list[tuple[int,int]]",
) -> int:
    visited[v] = True
    discover_on[v] = lap
    reachable_on[v] = lap
    lap += 1

    for curr_v in adjs[v]:
        if not visited[curr_v]:
            parent[curr_v] = v

            critical_links(
                curr_v,
                adjs,
                visited,
                lap,
                parent,
                reachable_on,
                discover_on,
                criticals,
            )

            if reachable_on[curr_v] > discover_on[v]:
                criticals.append((min(curr_v, v), max(curr_v, v)))

            reachable_on[v] = min(reachable_on[v], reachable_on[curr_v])

        elif parent[v] != curr_v:
            reachable_on[v] = min(reachable_on[v], discover_on[curr_v])

    return lap


lines = sys.stdin.read().splitlines()
line_i = 0
size = len(lines)
r = []  # type: list[str] # type: ignore
while line_i < size:
    line = lines[line_i]
    servers = int(line)
    if servers < 2:
        r.append("0 critical links\n\n")
        line_i += 2 + servers
        continue

    line_i += 1

    g = [None for _ in range(servers)]  # type: list[list[int]] # type: ignore
    order = []  # type: list[int] # type: ignore
    for line_i in range(line_i, line_i + servers):
        words = lines[line_i].split()
        v = int(words[0])
        order.append(v)
        g[v] = [] if len(words) == 2 else [int(n) for n in words[2:]]

    line_i += 2

    padres = [-1] * servers
    menor_alcanzable = [servers] * servers
    visited = [False] * servers
    n_discovered = [-1] * servers

    ans = []  # type: list[tuple[int, int]] # type: ignore
    lap = 1
    for v in order:
        if not visited[v]:
            lap = critical_links(
                v, g, visited, lap, padres, menor_alcanzable, n_discovered, ans
            )

    ans.sort(key=lambda x: (x[0], x[1]))

    r.append("%d critical links\n" % len(ans))
    r.extend("%d - %d\n" % (v, n) for v, n in ans)
    r.append("\n")

sys.stdout.writelines(r)
