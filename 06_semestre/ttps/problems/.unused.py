# def maximize_strength(strengths):
#     def dfs(player, assigned_positions, current_strength):
#         nonlocal max_strength
#         if player == 11:  # All players are assigned
#             max_strength = max(max_strength, current_strength)
#             return

#         for position in range(11):
#             if not assigned_positions[position] and strengths[player][position] > 0:
#                 # Assign this player to this position
#                 assigned_positions[position] = True
#                 dfs(
#                     player + 1,
#                     assigned_positions,
#                     current_strength + strengths[player][position],
#                 )
#                 assigned_positions[position] = False  # Backtrack

#     max_strength = 0
#     dfs(0, [False] * 11, 0)
#     return max_strength

# def sum_up_to(seq: t.Sequence[int], k: int) -> int:
#     N = len(seq1) + 1
#     K = k + 1
#     cache = [0 for _ in range(N * K)]

#     for i in range(1, N):
#         row_i = i * K
#         for j in range(1, K):
#             prev = cache[row_i - K + j]

#             if seq1[i - 1] > j:
#                 cache[row_i + j] = prev
#                 continue

#             new = cache[row_i - K + (j - seq1[i - 1])] + seq1[i - 1]
#             cache[row_i + j] = prev if prev > new else new
#             if cache[row_i + j] == k:
#                 print(1)
#                 return k


#     return cache[N * K - 1]

# def dijkstra(G: t.Dict[int, t.Dict[int, int]], s: int):
#     # G is the graph, w is the weight function, s is the start vertex
#     D = {v: float("inf") for v in G}  # Initialize distances to infinity
#     P = {v: t.cast(t.Union[int, None], None) for v in G}  # Predecessor map
#     D[s] = 0  # Distance to the source is 0

#     # Priority queue to store (distance, vertex) pairs
#     priority_queue = [(0, s)]
#     known = t.cast(t.Set[int], set())  # Set of known vertices

#     while priority_queue:
#         # Get the vertex with the smallest distance
#         _dist_u, u = heapq.heappop(priority_queue)

#         if u in known:
#             continue

#         known.add(u)  # Mark u as known

#         # Check all adjacent vertices of u
#         for v, weight_uv in G.get(u,dict()).items():
#             if v not in known:
#                 # Relaxation step
#                 if D[v] > D[u] + weight_uv:
#                     D[v] = D[u] + weight_uv
#                     P[v] = u
#                     heapq.heappush(priority_queue, (D[v], v))

#     return D, P


# lines = sys.stdin.readlines()
# line_i = 1
# line = lines[0]
# cases = 0
# r = ""
# while line != "0 0 0":
#     cases += 1
#     c, s, q = map(int, line.split())
#     g = t.cast(t.Dict[int, t.Dict[int, int]], {})

#     for i in range(line_i, line_i + s):
#         c1, c2, d = map(int, lines[i].split())
#         if c1 in g:
#             g[c1][c2] = d
#         else:
#             g[c1] = {c2: d}
#         if c2 in g:
#             g[c2][c1] = d
#         else:
#             g[c2] = {c1: d}
#     r+='Case #' + str(cases) + '\n'
#     for i in range(line_i + s, line_i + s + q):
#         a, b = map(int, lines[i].split())
#         d,p = dijkstra(g, a)
#         # print(*res, sep="\n")
#         # print(res[0][b])
#         j = b
#         m = 0
#         tmp = p.get(j)
#         while tmp:
#             if g[j][tmp] > m:
#                 m = g[j][tmp]
#             j = tmp
#             tmp = p[tmp]
#         if m == 0:
#             r+= 'no path\n'
#         elif m> 80:
#             r+= '80\n'
#         else:
#             r+=str(m) +'\n'
#     line_i += s + q
#     # print(line_i-2, lines[line_i-2])
#     # print(line_i-1, lines[line_i-1])
#     line = lines[line_i]
#     line_i += 1
#     r+='\n'

# sys.stdout.write(r)


# def bfs_min_path(
#     start_node: int, goal_node: int, graph: t.List[t.List[int]]
# ) -> t.List[int]:
#     if goal_node in graph[start_node]:
#         return [start_node, goal_node]

#     queue = deque((start_node,))
#     n = len(graph)
#     distances = [float("inf")] * n  # Use a list for distances
#     predecessors = t.cast(
#         t.List[t.Union[None, int]], [None] * n
#     )  # Use a list for predecessors
#     distances[start_node] = 0

#     while queue:
#         v = queue.popleft()

#         for w in graph[v]:
#             if distances[w] == float("inf"):  # If w is unvisited
#                 distances[w] = distances[v] + 1
#                 predecessors[w] = v  # Set the predecessor of w as t
#                 queue.append(w)

#                 if w == goal_node:  # Stop when the goal is found
#                     break

#     # Reconstruct the path from goal_node to start_node using predecessors
#     path = t.cast(t.List[int], [])
#     current = goal_node
#     while current is not None:
#         path.append(current)
#         current = predecessors[current]

#     path.reverse()  # Reverse the path to get it from start_node to goal_node
#     return path if path[0] == start_node else []

# import math
# import sys


# MAX_VALUE = 1000000


# def wheel_sieve_of_eratosthenes(limit: int) -> "list[int]":
#     sieve_bound = (limit - 1) // 2
#     sieve = [False] * (sieve_bound + 1)
#     crosslimit = (int(limit**0.5) - 1) // 2
#     for i in range(1, crosslimit + 1):
#         if sieve[i] is False:
#             for j in range(2 * i * (i + 1), sieve_bound + 1, 2 * i + 1):
#                 sieve[j] = True

#     # discart 2 and 5 since are manually used in last_nonzero_digit
#     sieve[2] = True
#     sieve[5] = True
#     return [2 * i + 1 for i in range(1, sieve_bound + 1) if sieve[i] is False]


# def last_nonzero_digit(n: int, primes: "list[int]") -> str:
#     log_n = math.log(n)
#     lcm = 1
#     # Only need last digit, so use modulo 10
#     for p in primes:
#         if p > n:
#             break

#         # Use modular exponentiation for last digit
#         lcm = (lcm * (p ** (log_n // math.log(p)))) % 10

#     # Pre-calculate powers of 2 and 5 to handle trailing zeros
#     pow_2 = log_n // 0.6931471805599453  # math.log(2)
#     pow_5 = log_n // 1.6094379124341003  # math.log(5)

#     # Handle 2 and 5 separately to account for trailing zeros
#     lcm = (lcm * (2 ** (pow_2 - pow_5))) % 10

#     return "%d\n" % lcm


# primes = wheel_sieve_of_eratosthenes(MAX_VALUE)

# # Process input more efficiently
# lines = sys.stdin.read().split()
# result = []  # type: list[str] # type: ignore

# for line in lines:
#     n = int(line)
#     if n == 0:
#         break

#     result.append(last_nonzero_digit(n, primes))

# sys.stdout.writelines(result)
