"""
[vjudge.net/problem/SPOJ-ELIS](https://vjudge.net/problem/SPOJ-ELIS)

Given a list of numbers A output the length of the longest increasing
 subsequence. An increasing subsequence is defined as a set {i0 , i1 , i2 , i3
 , ... , ik} such that 0 <= i0 < i1 < i2 < i3 < ... < ik < N and A[ i0 ] <
 A[ i1 ] < A[ i2 ] < ... < A[ ik ]. A longest increasing subsequence is a
 subsequence with the maximum k (length).

i.e. in the list {33 , 11 , 22 , 44}

the subsequence {33 , 44} and {11} are increasing subsequences while {11, 22,
 44} is the longest increasing subsequence.

Input
First line contain one number N (1 <= N <= 10) the length of the list A.

Second line contains N numbers (1 <= each number <= 20), the numbers in the list
 A separated by spaces.

Output
One line containing the lenght of the longest increasing subsequence in A.

Example
Input:
5
1 4 2 4 3

Output:
3
"""

import sys
import typing as t


size = int(sys.stdin.readline())
numbers = tuple(int(n) for n in sys.stdin.readline().split())


def lis(seq: t.Sequence[int]) -> int:
    cache = [0] * size
    ans = 0
    for i in range(size):
        cache[i] = 1
        for j in range(i):
            if seq[j] < seq[i] and cache[j] + 1 > cache[i]:
                cache[i] = cache[j] + 1

        if cache[i] > cache[ans]:
            ans = i

    return cache[ans]


sys.stdout.write(str(lis(numbers)))
