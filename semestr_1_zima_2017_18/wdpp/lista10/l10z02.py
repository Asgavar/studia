#!/usr/bin/env python3.6

import itertools


def is_length_possible(word1, word2, result):
    return len(result) <= max(len(word1), len(word2)) + 1


def is_solved(word1, word2, result, lett_values):
    word1_value = compute_value(word1, lett_values)
    word2_value = compute_value(word2, lett_values)
    result_value = compute_value(result, lett_values)
    # print(f'word1: {word1_value}')
    # print(f'word2: {word2_value}')
    # print(f'result: {result_value}')
    return (word1_value + word2_value) == result_value


def compute_value(word_str, lett_values):
    val_list = [str(lett_values[c]) for c in word_str]
    val_int = int(''.join(val_list))
    # print(val_list)
    # print(val_int)
    return val_int


def get_letters(word):
    return ''.join(set(word))


def solve(equation_str):
    """
    Zakładam, że napis jest ładnie sformatowany.
    """
    splitted = equation_str.split()
    print(splitted)
    word1 = splitted[0]
    word2 = splitted[2]
    result = splitted[4]
    if not is_length_possible(word1, word2, result):
        return {}
    unique_letters = get_letters(word1+word2+result)
    combs = itertools.permutations(range(10), len(unique_letters))
    for possib2 in itertools.permutations(unique_letters):
        for c in combs:
            guess = dict(zip(possib2, c))
            # print(guess)
            if is_solved(word1, word2, result, guess):
                print(guess)
                return guess
    print('brak rozwiazan')
    return {}


if __name__ == '__main__':
    solve('send + more = money')
    solve('ciacho + ciacho = nadwaga')
    solve('ciacho + icacho = nadwaga')
