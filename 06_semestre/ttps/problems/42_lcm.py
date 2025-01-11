"""
https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1621

All of you know about LCM (Least Common Multiple). For example LCM of 4 and 6 is
12. LCM can also be defined for more than 2 integers. LCM of 2, 3, 5 is 30. In
the same way we can define LCM of first N integers. The LCM of first 6 numbers
is 60.

As you will see LCM will increase rapidly with N. So we are not interested in
the exact value of the LCM but we want to know the last nonzero digit of that.
And you have to find that effeciently.

Input
Each line contains one nonzero positive integer which is not greater than
1000000. Last line will contain zero indicating the end of input. This line
should not be processed. You will need to process maximum 1000 lines of input.

Output
For each line of input, print in a line the last nonzero digit of LCM of first 1
to N integers.

Sample Input
3
5
10
0

Sample Output
6
6
2
**ENDS IN (NEW) LINE**
"""

# implemented with:
# https://stackoverflow.com/a/75777988
# https://math.stackexchange.com/a/659816
import math
import sys


MAX_VALUE = 1000000


def wheel_sieve_of_eratosthenes(limit: int) -> "list[int]":
    sieve_bound = ((limit - 1) // 2) + 1
    sieve = [False] * sieve_bound
    crosslimit = (int(limit**0.5) - 1) // 2
    for i in range(1, crosslimit + 1):
        if sieve[i] is False:
            for j in range(2 * i * (i + 1), sieve_bound, 2 * i + 1):
                sieve[j] = True

    # discart 2 and 5 since are manually used in last_nonzero_digit
    sieve[2] = True
    sieve[5] = True
    return [2 * i + 1 for i in range(1, sieve_bound) if sieve[i] is False]


primes = wheel_sieve_of_eratosthenes(MAX_VALUE)

lines = sys.stdin.read().split()
r = []  # type: list[str] # type: ignore

for line in lines:
    n = int(line)
    if n == 0:
        break

    log_n = math.log(n)
    lcm = 1
    for p in primes:
        if p > n:
            break

        # modular exponentiation for last digit
        lcm = (lcm * (p ** math.floor(log_n / math.log(p)))) % 10

    # handle 2 and 5 to handle trailing zeros
    pow_2 = math.floor(log_n / 0.6931471805599453)  # math.log(2)
    pow_5 = math.floor(log_n / 1.6094379124341003)  # math.log(5)

    lcm = (lcm * (2 ** (pow_2 - pow_5))) % 10

    r.append("%d\n" % lcm)

sys.stdout.writelines(r)
