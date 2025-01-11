"""
[wikipedia.org/wiki/Longest_increasing_subsequence](
    https://en.wikipedia.org/wiki/Longest_increasing_subsequence
)

P = array of length N
M = array of length N + 1
M[0] = -1 // undefined so can be set to any value

L = 0
for i in range 0 to N-1: //N-1 included
    // Binary search for the smallest positive l ≤ L
    // such that X[M[l]] > X[i]
    lo = 1
    hi = L + 1
    while lo < hi:
        mid = lo + floor((hi-lo)/2) // lo <= mid < hi
        if X[M[mid]] >= X[i]
            hi = mid
        else: // if X[M[mid]] < X[i]
            lo = mid + 1

    // After searching, lo == hi is 1 greater than the
    // length of the longest prefix of X[i]
    newL = lo

    // The predecessor of X[i] is the last index of
    // the subsequence of length newL-1
    P[i] = M[newL-1]
    M[newL] = i

    if newL > L:
        // If we found a subsequence longer than any we've
        // found yet, update L
        L = newL

// Reconstruct the longest increasing subsequence
// It consists of the values of X at the L indices:
// ...,  P[P[M[L]]], P[M[L]], M[L]
S = array of length L
k = M[L]
for j in range L-1 to 0: //0 included
    S[j] = X[k]
    k = P[k]

return S
"""

import typing as t


def lis_sequence(seq: t.Sequence[int]) -> t.Sequence[int]:
    size = len(seq)
    idxs = [0] * size
    M = [-1] * (size + 1)
    ssize = 0
    for i in range(size):
        li = 1
        hi = ssize + 1
        while li < hi:
            mid = li + (hi - li) // 2
            if seq[M[mid]] <= seq[i]:
                hi = mid
            else:
                li = mid + 1

        new_ssize = li
        idxs[i] = M[new_ssize - 1]
        M[new_ssize] = i

        if new_ssize > ssize:
            ssize = new_ssize

    out = [0] * ssize
    k = M[ssize]
    for i in range(ssize - 1, -1, -1):
        out[i] = seq[k]
        k = idxs[k]

    return out

def lis_indices(seq: t.Sequence[int]) -> t.List[int]:
    size = len(seq)
    maxs = [0] * size
    M = [-1] * (size + 1)
    ssize = 0
    for i in range(size):
        li = 1
        hi = ssize + 1
        while li < hi:
            mid = li + (hi - li) // 2
            if seq[M[mid]] >= seq[i]:
                hi = mid
            else:
                li = mid + 1

        new_ssize = li
        maxs[i] = M[new_ssize - 1]
        M[new_ssize] = i

        if new_ssize > ssize:
            ssize = new_ssize

    idx_seq = [0] * ssize
    k = M[ssize]
    for i in range(ssize - 1, -1, -1):
        idx_seq[i] = k
        k = maxs[k]
    return idx_seq

if __name__ == "__main__":
    print(lis_sequence([2, 8, 9, 5, 6, 7, 1]))
    print(lis_indices([2, 8, 9, 5, 6, 7, 1]))
    print(lis_sequence([1]))
