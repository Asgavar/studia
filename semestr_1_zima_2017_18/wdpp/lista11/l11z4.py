def ppn(word):
    max_so_far = 1
    ret_str = ''
    mapping = {}
    for c in word:
        if c not in mapping:
            mapping[c] = str(max_so_far)
            max_so_far += 1
        ret_str += mapping[c]
    return '-'.join(ret_str)


if __name__ == '__main__':
    print(ppn('tata'))
    print(ppn('indianin'))
