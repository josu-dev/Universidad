"""
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1109

Euler proved in one of his classic theorems that prime numbers are infinite in
number. But can every number be expressed as a summation of four positive
primes? I don't know the answer. May be you can help!!! I want your solution to
be very efficient as I have a 386 machine at home. But the time limit specified
above is for a Pentium III 800 machine. The definition of prime number for this
problem is “A prime number is a positive number which has exactly two distinct
integer factors”. As for example 37 is prime as it has exactly two distinct
integer factors 37 and 1.

Input
The input contains one integer number N (N ≤ 10000000) in every line. This is
the number you will have to express as a summation of four primes. Input is
terminated by end of file.

Output
For each line of input there is one line of output, which contains four prime
numbers according to the given condition. If the number cannot be expressed as a
summation of four prime numbers print the line 'Impossible.' in a single line.
There can be multiple solutions. Any good solution will be accepted.

Sample Input
24
36
46

Sample Output
3 11 3 7
3 7 13 13
11 11 17 7
**ENDS IN NEW LINE**
"""

# implemented with:
# https://www.geeksforgeeks.org/n-expressed-sum-4-prime-numbers/
import math
import sys
import typing as t


MAX_SIZE = 10000000


def sieve_of_eratosthenes(limit: int):
    is_prime = [True] * (limit + 1)
    is_prime[0] = False
    is_prime[1] = False
    for i in range(2, int(math.sqrt(limit)) + 1):
        if is_prime[i]:
            for i in range(i * i, limit + 1, i):
                is_prime[i] = False

    primes = [p for p in range(2, limit + 1) if is_prime[p]]
    return primes, is_prime


primes_cache, is_prime_cache = sieve_of_eratosthenes(MAX_SIZE)


def sum_four_primes(n: int):
    if n <= 7:
        return None

    if n % 2 != 0:
        n = n - 5
        for prime in primes_cache:
            if is_prime_cache[n - prime]:
                return 2, 3, prime, n - prime

        return None

    n = n - 4
    for prime in primes_cache:
        if is_prime_cache[n - prime]:
            return 2, 2, prime, n - prime

    return None


lines = sys.stdin.read().split()
r = t.cast("list[str]", [])

for line in lines:
    n = int(line)

    primes = sum_four_primes(n)
    if primes is None:
        r.append("Impossible.\n")
        continue

    r.append("%d %d %d %d\n" % primes)

sys.stdout.writelines(r)
