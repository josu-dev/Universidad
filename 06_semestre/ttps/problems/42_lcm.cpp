#include <iostream>
#include <vector>
#include <cmath>
#include <string>

const int MAX_VALUE = 1000000;

std::vector<int> sieve_of_eratosthenes(int limit) {
    int sieve_bound = (limit - 1) / 2;
    std::vector<bool> sieve(sieve_bound + 1, false);
    int crosslimit = (int(sqrt(limit)) - 1) / 2;

    for (int i = 1; i <= crosslimit; i++) {
        if (sieve[i] == false) {
            for (int j = 2 * i * (i + 1); j <= sieve_bound; j += 2 * i + 1) {
                sieve[j] = true;
            }
        }
    }

    sieve[2] = true;
    sieve[5] = true;

    std::vector<int> primes;
    for (int i = 1; i <= sieve_bound; i++) {
        if (!sieve[i]) {
            primes.push_back(2 * i + 1);
        }
    }
    
    return primes;
}

std::string last_nonzero_digit(int n, const std::vector<int>& primes) {
    double log_n = log(n);
    int lcm = 1;

    // Pre-calculate powers of 2 and 5
    int pow_2 = log_n / 0.6931471805599453;  // log(2)
    int pow_5 = log_n / 1.6094379124341003;  // log(5)

    for (int p : primes) {
        if (p > n) {
            break;
        }

        int power = log_n / log(p);
        int result = 1;
        
        for (int i = 0; i < power; i++) {
            result = (result * p) % 10;
        }
        lcm = (lcm * result) % 10;
    }

    int result = 1;
    for (int i = 0; i < (pow_2 - pow_5); i++) {
        result = (result * 2) % 10;
    }
    lcm = (lcm * result) % 10;

    return std::to_string(lcm) + "\n";
}

int main() {
    std::vector<int> primes = sieve_of_eratosthenes(MAX_VALUE);
    std::vector<std::string> result;
    
    std::string line;
    while (std::getline(std::cin, line)) {
        int n = std::stoi(line);
        if (n == 0) {
            break;
        }
        result.push_back(last_nonzero_digit(n, primes));
    }

    for (const std::string& s : result) {
        std::cout << s;
    }

    return 0;
}
