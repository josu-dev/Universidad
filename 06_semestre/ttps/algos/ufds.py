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

    def same_set(self, i: int, j: int) -> bool:
        return i == j or self.find_set(i) == self.find_set(j)

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

    def count_set_nodes(self, i: int) -> int:
        return self.sizes[self.find_set(i)]

    def all_roots(self) -> t.List[int]:
        return [i for i in range(len(self.p)) if self.p[i] == i]


size: int = 1
ufds_p = [i for i in range(size)]
ufds_rank = [0] * size
ufds_sizes = [1] * size


def ufds_find_set(i: int) -> int:
    parent = ufds_p[i]
    if i == parent:
        return i

    parent = ufds_p[i] = ufds_find_set(parent)
    return parent


def ufds_same_set(i: int, j: int) -> bool:
    return i == j or ufds_find_set(i) == ufds_find_set(j)


def ufds_union_set(i: int, j: int) -> int:
    x = ufds_find_set(i)
    y = ufds_find_set(j)
    if x == y:
        return x

    if ufds_rank[x] > ufds_rank[y]:
        ufds_p[y] = x
        ufds_sizes[x] = ufds_sizes[x] + ufds_sizes[y]
        return x

    ufds_p[x] = y
    if ufds_rank[x] == ufds_rank[y]:
        ufds_rank[y] = y + 1

    ufds_sizes[y] = ufds_sizes[x] + ufds_sizes[y]
    return y


def ufds_count_sets() -> int:
    return sum(1 for i in range(len(ufds_p)) if ufds_p[i] == i)


def ufds_count_set_nodes(i: int) -> int:
    return ufds_sizes[ufds_find_set(i)]
