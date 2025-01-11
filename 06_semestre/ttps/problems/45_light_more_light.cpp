#include <iostream>
#include <vector>
#include <cmath>

const int MAX_LIMIT = 65536;
bool is_prime[MAX_LIMIT + 1];
std::vector<int> primes;

void sieve_of_eratosthenes() {
    std::fill(is_prime, is_prime + MAX_LIMIT + 1, true);
    is_prime[0] = is_prime[1] = false;
    for (int i = 2; i <= std::sqrt(MAX_LIMIT); i++) {
        if (is_prime[i]) {
            for (int j = i * i; j <= MAX_LIMIT; j += i) {
                is_prime[j] = false;
            }
        }
    }
    for (int i = 2; i <= MAX_LIMIT; i++) {
        if (is_prime[i]) {
            primes.push_back(i);
        }
    }
}

long long divisors_p(long long n) {
    long long total = 1;
    for (int p : primes) {
        if (static_cast<long long>(p) * p > n) {
            break;
        }
        long long curr = 0;
        while (n % p == 0) {
            curr++;
            n /= p;
        }
        total *= curr + 1;
    }
    return total * (n > 1 ? 2 : 1);
}

int main() {
    sieve_of_eratosthenes();
    std::string line;
    while (std::getline(std::cin, line)) {
        long long n = std::stoll(line);
        if (n < 2) {
            if (n == 0) {
                break;
            }
            std::cout << "yes\n";
            continue;
        }
        if ((divisors_p(n) % 2) == 0) {
            std::cout << "no\n";
        } else {
            std::cout << "yes\n";
        }
    }
    return 0;
}
