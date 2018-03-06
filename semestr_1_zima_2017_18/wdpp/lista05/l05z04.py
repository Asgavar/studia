def only_one(s):
    s = sorted(list(zip(s, range(len(s)))))
    x = 0
    s_unique = []
    values_present = set()
    while x < len(s):
        if s[x][0] not in values_present:
            s_unique.append(s[x])
            values_present.add(s[x][0])
        x += 1
    s = sorted(s_unique, key=lambda x: x[1])
    ret = []
    for x in s:
        ret.append(x[0])
    return ret


if __name__ == '__main__':
    print(only_one([1, 6, 5, 7, 94, 5, 8, 94, 3]))
    print(only_one([7, 7, 7, 8, 7, 7, 9, 9, 9, 7]))
