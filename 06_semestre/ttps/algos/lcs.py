"""
https://en.wikipedia.org/wiki/Longest_common_subsequence
function LCSLength(X[1..m], Y[1..n])
    C = array(0..m, 0..n)
    for i := 0..m
        C[i,0] = 0
    for j := 0..n
        C[0,j] = 0
    for i := 1..m
        for j := 1..n
            if X[i] = Y[j]
                C[i,j] := C[i-1,j-1] + 1
            else
                C[i,j] := max(C[i,j-1], C[i-1,j])
    return C[m,n]
"""

import typing as t


def lcs_length(seq1: t.Sequence, seq2: t.Sequence) -> int:
    m = len(seq1)
    n = len(seq2)
    cache = list(0 for _ in range((m + 1) * (n + 1)))
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if seq1[i - 1] == seq2[j - 1]:
                cache[i * (n + 1) + j] = cache[(i - 1) * (n + 1) + (j - 1)] + 1
            else:
                cache[i * (n + 1) + j] = max(
                    cache[i * (n + 1) + (j - 1)], cache[(i - 1) * (n + 1) + j]
                )

    return cache[m * (n + 1) + n]


if __name__ == "__main__":
    test = [3, 2, 15, 40], [2, 6, 15, 40, 60]
    print(lcs_length(*test))
