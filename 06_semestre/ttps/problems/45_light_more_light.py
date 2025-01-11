"""
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1051

There is man named ”mabu” for switching on-off light in our University. He
switches on-off the lights in a corridor. Every bulb has its own toggle switch.
That is, if it is pressed then the bulb turns on.
Another press will turn it off. To save power consumption (or may be he is mad
or something else) he does a peculiar thing. If in a corridor there is n bulbs,
he walks along the corridor back and forth n times and in i-th walk he toggles
only the switches whose serial is divisable by i. He does not press any switch
when coming back to his initial position. A i-th walk is defined as going down
the corridor (while doing the peculiar thing) and coming back again. Now you
have to determine what is the final condition of the last bulb. Is it on or off?

Input
The input will be an integer indicating the n'th bulb in a corridor. Which is
less then or equals 2^32 -1. A zero indicates the end of input. You should not
process this input.

Output
Output 'yes' if the light is on otherwise 'no', in a single line.

Sample Input
3
6241
8191
0

Sample Output
no
yes
no
**ENDS IN NEW LINE**
"""

import math
import sys


MAX_POSSIBLE_PRIME = math.ceil(math.sqrt(2**32 - 1))


def sieve_of_eratosthenes(limit: int):
    is_prime = [True] * (limit + 1)
    is_prime[0] = False
    is_prime[1] = False
    for i in range(2, int(math.sqrt(limit)) + 1):
        if is_prime[i]:
            for i in range(i * i, limit + 1, i):
                is_prime[i] = False

    return [p for p in range(2, limit + 1) if is_prime[p]]


def divisors(n: int) -> int:
    total = 1

    for p in primes:
        if p * p > n:
            break

        curr = 0

        while n % p == 0:
            curr += 1
            n //= p

        total *= curr + 1

    return total * (2 if n > 1 else 1)


primes = sieve_of_eratosthenes(MAX_POSSIBLE_PRIME)

lines = sys.stdin.read().split()
r = []  # type: list[str] # type: ignore

for line in lines:
    n = int(line)
    if n < 2:
        if n == 0:
            break

        r.append("yes\n")
        continue

    if (divisors(n) % 2) == 0:
        r.append("no\n")
    else:
        r.append("yes\n")

sys.stdout.writelines(r)
