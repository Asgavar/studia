#!/usr/bin/env python3


def only_one(L):
    ret = []
    for e in L:
        if e not in ret:
            ret.append(e)
    return ret


if __name__ == '__main__':
    print(only_one([1, 2, 3, 4, 5, 6, 7, 1, 3, 5, 5, 5]))
