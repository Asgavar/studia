#include <algorithm>
#include <cctype>
#include <cmath>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

bool is_string_valid_int64(std::string to_check) {
    // TODO: znak z przodu
    return std::all_of(to_check.begin(), to_check.end(), isdigit);
}

int64_t string_to_int64(std::string to_convert) {
    const short ASCII_DIGIT_OFFSET = 48;
    int64_t value = 0;
    int32_t power_of_10 = to_convert.length() - 1;
    for (char c : to_convert) {
        int64_t char_value = c - ASCII_DIGIT_OFFSET;
        char_value *= pow(10, power_of_10);
        value += char_value;
        --power_of_10;
    }
    return value;
}

bool is_prime(int64_t number) {
    int64_t threshold = (int64_t) sqrt(number);
    for (int x = 2; x < threshold; x++) {
        // std::cout << x << std::endl;
        if (number % x == 0)
            return false;
    }
    return true;
}

std::vector<int64_t> factorize(int64_t n) {
    // TODO: int64 overflow
    std::vector<int64_t> primes;
    if (n == -1 || n == 0 || n == 1 || is_prime(n)) {
        primes.push_back(n);
        return primes;
    }
    if (n < 0) {
        primes.push_back(-1);
        n *= -1;
    }
    int64_t current_prime = 2;
    while (n > 1) {
        while (n % current_prime == 0) {
            primes.push_back(current_prime);
            n /= current_prime;
        }
        ++current_prime;
    }
    return primes;
}

std::string to_output_string(int64_t number, std::vector<int64_t> primes) {
    std::string ret;
    ret += std::to_string(number);
    ret += " = ";
    for (int64_t prime : primes) {
        ret += std::to_string(prime);
        ret += " * ";
    }
    ret.pop_back();
    ret.pop_back();
    return ret;

}

int main(int argc, char* argv[]) {
    if (argc == 1)
        std::cerr << "Użycie: ./lista01 liczba1 [liczba2] [liczba3] ...\n";
    std::vector<std::string> args;
    /* od 1, bo pod indeksem 0 znajduje sie nazwa programu */
    for (auto x = 1; x < argc; x++) {
        std::string as_string = std::string(argv[x]);
        args.push_back(as_string);
    }
    if (! std::all_of(args.begin(), args.end(), is_string_valid_int64))
        throw std::invalid_argument("Niepoprawny argument");
    std::vector<int64_t> numbers;
    // std::generate(std::execution::sequenced_policy, args.begin(), args.end(), string_to_int64);
    for (std::string s : args) {
        int64_t as_int64 = string_to_int64(s);
        numbers.push_back(as_int64);
    }
    for (int64_t number : numbers) {
        std::cout << to_output_string(number, factorize(number)) << std::endl;
    }
}
