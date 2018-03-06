def caesar(word, key):
    alphabet = 'aąbcćdeęfghijklłmnńoóprsśtuwyzźż'
    translations = {}
    for x in range(len(alphabet)):
        translations[alphabet[x]] = (alphabet[(x+key) % len(alphabet)])
    ret = ''
    alphabet_set = set(alphabet)
    for c in word:
        if c not in alphabet_set:
            continue
        ret += translations[c]
    return ret

if __name__ == '__main__':
    print(caesar('abcde', 1))
    before = 'bardzodługiesłowojednakpozbawionespacji'
    after = caesar(before, 127)
    print(after)
    print(caesar(after, -127))
