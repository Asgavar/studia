#!/usr/bin/env python3.6

import itertools


def split_to_pairs(dataset):
    ret = list(itertools.permutations(dataset, 2))
    for element in dataset:
        ret.append((element, element))
    return ret


def addition(op1, op2):
    return eval('op1 + op2')


def substraction(op1, op2):
    return eval('op1 - op2')


def multiplication(op1, op2):
    return eval('op1 * op2')


def division(op1, op2):
    return eval('op1 / op2')


if __name__ == '__main__':
    numbers = set([1, 2, 3, 4])
    pairs = split_to_pairs(numbers)
    valid_additions = [f'{p[0]} + {p[1]}' for p in pairs if addition(*p) in numbers]
    valid_substractions= [f'{p[0]} - {p[1]}' for p in pairs if substraction(*p) in numbers]
    valid_multiplications = [f'{p[0]} * {p[1]}' for p in pairs if multiplication(*p) in numbers]
    valid_divisions = [f'{p[0]} / {p[1]}' for p in pairs if division(*p) in numbers]
    print(
        '\n'.join(valid_additions + valid_substractions + valid_multiplications + valid_divisions)
    )
