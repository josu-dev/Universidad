import typing as t


def sum_up_to(seq: t.Sequence[int], k: int) -> int:
    N = len(seq1) + 1
    K = k + 1

    prev = [0] * K
    curr = [0] * K

    for i in range(1, N):
        actual = seq1[i - 1]
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
