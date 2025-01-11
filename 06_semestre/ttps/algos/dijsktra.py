import heapq
import sys


INF = float("inf")


def dijkstra(
    graph: "dict[int, dict[int, int]]", start: int
) -> "tuple[dict[int, int | float], dict[int, int | None]]":
    distances = {node: INF for node in graph}
    distances[start] = 0
    previous = {
        node: None for node in graph
    }  # type: dict[int, int | None] # type: ignore

    pq = [(0, start)]
    visited = set()  # type: set[int] # type: ignore

    while pq:
        curr_distance, curr_node = heapq.heappop(pq)

        if curr_node in visited:
            continue

        visited.add(curr_node)

        for neighbor, weight in graph[curr_node].items():
            distance = curr_distance + weight
            if distance >= distances[neighbor]:
                continue

            distances[neighbor] = distance
            previous[neighbor] = curr_node
            heapq.heappush(pq, (distance, neighbor))

    return distances, previous


def reconstruct_path(previous_nodes: Dict[str, str], start: str, end: str) -> List[str]:
    """
    Reconstructs the shortest path from start to end.

    Args:
    previous_nodes: Dictionary of previous nodes in the shortest path
    start: The starting node
    end: The destination node

    Returns:
    A list of nodes representing the shortest path
    """
    path = []
    current = end

    while current is not None:
        path.append(current)
        current = previous_nodes[current]

    # Reverse the path to go from start to end
    return path[::-1]
