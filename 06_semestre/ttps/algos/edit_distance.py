"""
function LevenshteinDistance(char s[0..m-1], char t[0..n-1]):
    // create two work vectors of integer distances
    declare int v0[n + 1]
    declare int v1[n + 1]

    // initialize v0 (the previous row of distances)
    // this row is A[0][i]: edit distance from an empty s to t;
    // that distance is the number of characters to append to  s to make t.
    for i from 0 to n:
        v0[i] = i

    for i from 0 to m - 1:
        // calculate v1 (current row distances) from the previous row v0

        // first element of v1 is A[i + 1][0]
        //   edit distance is delete (i + 1) chars from s to match empty t
        v1[0] = i + 1

        // use formula to fill in the rest of the row
        for j from 0 to n - 1:
            // calculating costs for A[i + 1][j + 1]
            deletionCost := v0[j + 1] + 1
            insertionCost := v1[j] + 1
            if s[i] = t[j]:
                substitutionCost := v0[j]
            else:
                substitutionCost := v0[j] + 1

            v1[j + 1] := minimum(deletionCost, insertionCost, substitutionCost)

        // copy v1 (current row) to v0 (previous row) for next iteration
        // since data in v1 is always invalidated, a swap without copy could be more efficient
        swap v0 with v1
    // after the last swap, the results of v1 are now in v0
    return v0[n]
"""

import typing as t


def edit_distance(seq1: t.Sequence[t.Any], seq2: t.Sequence[t.Any]) -> int:
    """
    https://github.com/lanl/pyxDamerauLevenshtein
    """
    m = len(seq1)
    n = len(seq2)
    first_differing_index = 0
    min_len = m if m < n else n
    while (
        first_differing_index < min_len
        and seq1[first_differing_index] == seq2[first_differing_index]
    ):
        first_differing_index += 1

    seq1 = seq1[first_differing_index:]
    seq2 = seq2[first_differing_index:]

    m = len(seq1)
    n = len(seq2)

    prev_dst = list(range(n + 1))
    curr_dst = [0] * (n + 1)

    for i in range(m):
        curr_dst[0] = i + 1
        to_cmp = seq1[i]
        for j in range(n):
            d = prev_dst[j + 1] + 1
            i = curr_dst[j] + 1
            s = prev_dst[j] + (0 if to_cmp == seq2[j] else 1)

            curr_dst[j + 1] = d if d < i and d < s else (i if i < s else s)

        prev_dst, curr_dst = curr_dst, prev_dst

    return prev_dst[n]


def edit_distance_compact(seq1: t.Sequence[t.Any], seq2: t.Sequence[t.Any]) -> int:
    """
    https://www.geeksforgeeks.org/edit-distance-dp-5/
    """
    m = len(seq1)
    n = len(seq2)
    if m == 0 or n == 0:
        return m + n

    prev = 0
    curr = list(range(n + 1))

    for i in range(m):
        prev = curr[0]
        curr[0] = i + 1
        to_cmp = seq1[i]
        for j in range(n):
            delete = curr[j + 1]
            i = curr[j]
            prev += -1 if to_cmp == seq2[j] else 0
            curr[j + 1] = 1 + (
                delete if delete < i and delete < prev else (i if i < prev else prev)
            )
            prev = delete

    return curr[n]
