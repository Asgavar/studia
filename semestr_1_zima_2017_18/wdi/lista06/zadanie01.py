if __name__ == '__main__':
    array = [1, 2, 7, 7, 38, 99]
    x = 8
    l = 0
    p = 4
    while (p - l) != 1:
        k = (l + p) // 2
        if array[k] < x:
            l = k
        else:
            p = k
    # obecnie l <= x <= p, a x mial stac przed tuz l
    l += 1
